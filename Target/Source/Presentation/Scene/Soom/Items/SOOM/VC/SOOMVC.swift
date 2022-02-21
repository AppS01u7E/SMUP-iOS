//
//  SOOMVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxSwift
import LBTATools
import BTImageView
import RxCocoa
import RxDataSources
import Then
import PinLayout
import FlexLayout

final class SOOMVC : baseVC<SOOMReactor>
{
    // MARK: - Properties
    private let rootContainer = UIView()
    private let alarmButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "bell")?.tintColor(SMUPAsset.smupGray7.color)
    }
    
    let postTableView = UITableView().then {
        $0.register(SOOMPostTableViewCell.self, forCellReuseIdentifier: SOOMPostTableViewCell.reusableID)
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.941, alpha: 1)
    }
    
    private let storyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.showsHorizontalScrollIndicator = false
        $0.register(SOOMStoryCollectionViewCell.self, forCellWithReuseIdentifier: SOOMStoryCollectionViewCell.reusableID)
        layout.itemSize = CGSize(width: 129, height: 68)
        $0.collectionViewLayout = layout
    }
    
    //MARK: - UI
    override func addView() {
        view.addSubViews(rootContainer)
    }
    
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.safeAreaInsets)
        rootContainer.flex.layout()
    }
    
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(storyCollectionView).marginHorizontal(3.6%).height(bound.width*0.23)
            flex.addItem(separatorView).marginTop(5).height(2)
            flex.addItem(postTableView).marginHorizontal(3.6%).height(603).bottom(0)
            
        }
    }
    
    override func configureVC() {
    }
    
    override func configureNavigation() {
        self.navigationItem.rightBarButtonItem = alarmButton
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    //MARK: - Reactor
    
    override func bindAction(reactor: SOOMReactor) {
        
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    
    override func bindView(reactor: SOOMReactor) {
        alarmButton.rx.tap
            .do(onNext: { [weak self] _ in
                let back : UIBarButtonItem = .init(title: "", style: .plain, target: self, action: nil)
                back.tintColor = .black
                self?.navigationItem.backBarButtonItem = back
            })
                .map { _ in Reactor.Action.alarmButtonDidTap }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: SOOMReactor) {
        let sharedState = reactor.state.share(replay: 2)
        
        let storyDS = RxCollectionViewSectionedAnimatedDataSource<SOOMStorySection>{
            _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: SOOMStoryCollectionViewCell.reusableID, for: ip) as? SOOMStoryCollectionViewCell else { return .init() }
            cell.model = item
            return cell
        }
        
        let PostDS = RxTableViewSectionedAnimatedDataSource<SOOMPostSection>{
            _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: SOOMPostTableViewCell.reusableID, for: ip) as? SOOMPostTableViewCell else { return .init() }
            cell.model = item
            return cell
        }
        
        
        sharedState
            .map(\.soomStorys)
            .map { [SOOMStorySection.init(header: "", items: $0)] }
            .bind(to: storyCollectionView.rx.items(dataSource: storyDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.soomPosts)
            .map { [SOOMPostSection.init(header: "", items: $0)] }
            .bind(to: postTableView.rx.items(dataSource: PostDS))
            .disposed(by: disposeBag)
    }
}
