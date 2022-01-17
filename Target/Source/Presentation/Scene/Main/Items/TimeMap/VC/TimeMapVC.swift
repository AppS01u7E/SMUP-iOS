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
    
    private let weekDayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        $0.contentInset = .init(top: 0, left: 5, bottom: 0, right: 5)
        $0.showsHorizontalScrollIndicator = false
        $0.register(TimeMapWeekCell.self, forCellWithReuseIdentifier: TimeMapWeekCell.reusableID)
        $0.collectionViewLayout = layout
    }
    
    private let scheduleTableView = UITableView()
    
    // MARK: - UI
    override func setUp() {
        weekDayCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    override func addView() {
        view.addSubViews(mainView)
        mainView.addSubViews(weekDayCollectionView)
    }
    override func setLayout() {
        mainView.snp.makeConstraints {
            $0.height.equalTo(bound.height*0.8205)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        weekDayCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.07)
            $0.height.equalTo(bound.height*0.1)
        }
    }
    override func configureVC() {
        self.view.backgroundColor = .systemGray5
    }
    override func configureNavigation() {
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
        bind(reactor: reactor)
    }
    
    // MARK: - Reactor
    override func bindState(reactor: TimeMapReactor) {
        
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
