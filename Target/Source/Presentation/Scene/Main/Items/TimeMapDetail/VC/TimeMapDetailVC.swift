//
//  TimeMapDetailVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxSwift
import UIKit
import RxGesture
import AnimatedCollectionViewLayout
import RxDataSources

final class TimeMapDetailVC: baseVC<TimeMapDetailReactor>{
    // MARK: - Properties
    private let transparentView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.1
    }
    
    private let bgView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private var currentIndex = 0
    
    private let timeMapsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.animator = LinearCardAttributesAnimator()
        
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
        $0.register(TimeMapDetailCell.self, forCellWithReuseIdentifier: TimeMapDetailCell.reusableID)
    }
    
    
    // MARK: - Init
    init(schedules: [TimeMap], current: Int){
        self.currentIndex = current
        super.init()
        
        Observable.just(schedules)
            .map { Reactor.Action.`init`($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    override func setUp() {
        timeMapsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubViews(transparentView, bgView)
        bgView.addSubViews(timeMapsCollectionView)
    }
    override func setLayout() {
        transparentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        bgView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(bound.width*0.841)
            $0.height.equalTo(bound.height*0.702)
        }
        timeMapsCollectionView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    override func configureVC() {
        view.backgroundColor = .clear
        bgView.layer.cornerRadius = 15
        bgView.clipsToBounds = true
        bgView.backgroundColor = .clear
        bind(reactor: reactor)
    }
    
    // MARK: - Reactor
    override func bindView(reactor: TimeMapDetailReactor) {
        transparentView.rx.tapGesture()
            .when(.recognized)
            .map { _ in Reactor.Action.transparentDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: TimeMapDetailReactor) {
        let sharedState = reactor.state.share(replay: 2)
        
        var dataSource = RxCollectionViewSectionedAnimatedDataSource<TimeMapDetailSection>{ ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: TimeMapDetailCell.reusableID, for: ip) as? TimeMapDetailCell else { return .init() }
            cell.delegate = self
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.schedulse)
            .map{ [TimeMapDetailSection(header: "", items: $0)]}
            .bind(to: timeMapsCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
}

// MARK: - Extension
extension TimeMapDetailVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: bound.width*0.841, height: bound.height*0.702)
    }
}

extension TimeMapDetailVC: TimeMapDetailCellDelegate{
    func goDirectButtonDidTap() {
        print("DEBUG")
    }
}
