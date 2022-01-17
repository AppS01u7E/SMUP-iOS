//
//  TimeMapVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxDataSources
import SwiftDate
import RxSwift

final class TimeMapVC: baseVC<TimeMapReactor>{
    // MARK: - Properties
    private let mainView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let selectedDate: Date
    
    private let selectedDateLabel = UILabel().then {
        $0.textColor = .black.withAlphaComponent(0.47)
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 16)
        $0.numberOfLines = 0
    }
    
    private let weekDayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        $0.contentInset = .init(top: 0, left: 5, bottom: 0, right: 5)
        $0.showsHorizontalScrollIndicator = false
        $0.register(TimeMapWeekCell.self, forCellWithReuseIdentifier: TimeMapWeekCell.reusableID)
        $0.collectionViewLayout = layout
    }
    
    private let scheduleTableView = UITableView().then {
        $0.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reusableID)
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 400
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Lifecycle
    init(selectedDate: Date){
        self.selectedDate = selectedDate
        super.init()
        self.configSelectedDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    override func setUp() {
        bind(reactor: reactor)
        weekDayCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let items: [TimeMapWeekSection] = [
            .init(header: "", items: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday])
        ]
        
        let timeMapDatasource = RxCollectionViewSectionedAnimatedDataSource<TimeMapWeekSection> { ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: TimeMapWeekCell.reusableID, for: ip) as? TimeMapWeekCell else { return .init() }
            cell.model = item
            return cell
        }
        
        Observable.just(items)
            .bind(to: weekDayCollectionView.rx.items(dataSource: timeMapDatasource))
            .disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubViews(mainView, selectedDateLabel)
        mainView.addSubViews(weekDayCollectionView, scheduleTableView)
    }
    override func setLayout() {
        mainView.snp.makeConstraints {
            $0.height.equalTo(bound.height*0.8205)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        selectedDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(23)
            $0.bottom.equalTo(mainView.snp.top).offset(-8)
        }
        weekDayCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.07)
            $0.height.equalTo(bound.height*0.1)
        }
        scheduleTableView.snp.makeConstraints {
            $0.top.equalTo(weekDayCollectionView.snp.bottom).offset(bound.height*0.078)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.07)
            $0.bottom.equalToSuperview()
        }
    }
    override func configureVC() {
        self.view.backgroundColor = .systemGray5
    }
    override func configureNavigation() {
        
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: TimeMapReactor) {
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: TimeMapReactor) {
        let sharedState = reactor.state.share(replay: 1)
        
        let timeMapDataSource = RxTableViewSectionedAnimatedDataSource<TimeMapScheduleSection>{ ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reusableID, for: ip) as? ScheduleTableViewCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.schedules)
            .map{ [TimeMapScheduleSection(header: "", items: $0)]}
            .bind(to: scheduleTableView.rx.items(dataSource: timeMapDataSource))
            .disposed(by: disposeBag)
    }
    
    override func bindView(reactor: TimeMapReactor) {
        self.weekDayCollectionView.rx.itemSelected
            .subscribe(onNext: {
                guard let cell = self.weekDayCollectionView.dequeueReusableCell(withReuseIdentifier: TimeMapWeekCell.reusableID, for: $0) as? TimeMapWeekCell else { return }
                cell.backgroundColor = SMUPAsset.smupMain3.color
                cell.didSelectItem()
                
            })
            .disposed(by: disposeBag)
        
        self.weekDayCollectionView.rx.itemDeselected
            .subscribe(onNext: {
                guard let cell = self.weekDayCollectionView.dequeueReusableCell(withReuseIdentifier: TimeMapWeekCell.reusableID, for: $0) as? TimeMapWeekCell else { return }
                cell.didDeSelectItem()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegate
extension TimeMapVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: bound.width*0.09, height: bound.height*0.09)
    }
}

// MARK: - Method
private extension TimeMapVC{
    func configSelectedDateLabel(){
        let str = NSMutableAttributedString(string: selectedDate.toString(.custom("yyyy년\nMM월 dd일")))
        str.setColorForText(textToFind: selectedDate.toString(.custom("yyyy년")), withColor: .black)
        str.setFontForText(textToFind: selectedDate.toString(.custom("yyyy년")), withFont: .init(font: SMUPFontFamily.Inter.semiBold, size: 20) ?? .init())
        selectedDateLabel.attributedText = str
    }
}
