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
    
    private let prevSchedultButton = UIButton().then {
        $0.setImage(.init(systemName: "chevron.left")?.tintColor(.black).downSample(size: .init(width: 20, height: 20)), for: .normal)
    }
        
    private let nextScheduleButton = UIButton().then {
        $0.setImage(.init(systemName: "chevron.right")?.tintColor(.black).downSample(size: .init(width: 20, height: 20)), for: .normal)
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
        view.addSubViews(prevSchedultButton, nextScheduleButton)
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
        prevSchedultButton.snp.makeConstraints {
            $0.centerY.equalTo(bgView)
            $0.leading.equalTo(view).inset(30)
        }
        nextScheduleButton.snp.makeConstraints {
            $0.centerY.equalTo(bgView)
            $0.trailing.equalTo(view).inset(30)
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
        bgView.rx.tapGesture()
            .when(.recognized)
            .map { _ in Reactor.Action.transparentDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        transparentView.rx.tapGesture()
            .when(.recognized)
            .map { _ in Reactor.Action.transparentDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        prevSchedultButton.rx.tap
            .do(onNext: { [weak self] in
                self?.timeMapsCollectionView.scrollToItem(at: .init(row: reactor.currentState.currentIndex-1, section: 0), at: .left, animated: true)
            })
            .map { Reactor.Action.prevDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nextScheduleButton.rx.tap
            .do(onNext: { [weak self] in
                self?.timeMapsCollectionView.scrollToItem(at: .init(row: reactor.currentState.currentIndex+1, section: 0), at: .right, animated: true)
            })
                .map { Reactor.Action.nextDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: TimeMapDetailReactor) {
        let sharedState = reactor.state.share(replay: 3)
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<TimeMapDetailSection>{ ds, tv, ip, item in
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
        
        sharedState
            .map(\.currentIndex)
            .filter{ $0 != self.currentIndex }
            .withUnretained(self)
            .do(onNext: { owner, item in
                owner.currentIndex = item
            })
            .subscribe(onNext: { owner, item in
                owner.timeMapsCollectionView.scrollToItem(at: .init(row: item, section: 0), at: .right, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension TimeMapDetailVC: UICollectionViewDelegateFlowLayout{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
        let yPoint = scrollView.frame.height / 2
        let center = CGPoint(x: xPoint, y: yPoint)
        if let index = timeMapsCollectionView.indexPathForItem(at: center){
            Observable.just(index.row)
                .map { Reactor.Action.indexDidChange($0) }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: bound.width*0.841, height: bound.height*0.702)
    }
}

extension TimeMapDetailVC: TimeMapDetailCellDelegate{
    func goDirectButtonDidTap() {
        print("DEBUG")
    }
}
