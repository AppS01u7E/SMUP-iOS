//
//  SearchVC.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxDataSources
import PinLayout
import FlexLayout
import RxSwift

final class SearchVC: baseVC<SearchReactor>{
    // MARK: - Properties
    private let rootContainer = UIView()
    private let searchTextField = UITextField(placeholder: "검색하실 SOOM 이름을 입력해주세요.").then {
        $0.addLeftImage(image: .init(systemName: "magnifyingglass")?.tintColor(SMUPAsset.smupGray3.color) ?? .init())
        $0.applyUnderline()
    }
    private let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.showsHorizontalScrollIndicator = false
        $0.register(SoomCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SoomCategoryCollectionViewCell.reusableID)
        $0.collectionViewLayout = layout
    }
    private let separatorView = UIView().then {
        $0.backgroundColor = SMUPAsset.smupGray3.color
    }
    private let soomTableView = UITableView().then {
        $0.register(SoomSearchResultCell.self, forCellReuseIdentifier: SoomSearchResultCell.reusableID)
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 300
        $0.separatorStyle = .none
    }
    
    // MARK: - UI
    override func setUp() {
        categoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.safeAreaInsets)
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(searchTextField).marginHorizontal(13%).height(40)
            flex.addItem(categoryCollectionView).marginHorizontal(3.6%).marginTop(13).height(bound.width*0.23)
            flex.addItem(separatorView).marginHorizontal(3.6%).marginTop(15).height(1)
            flex.addItem(soomTableView).marginHorizontal(9.6%).marginTop(15).height(75.89%).bottom(0)
        }
    }
    override func configureVC() {
        view.backgroundColor = SMUPAsset.smupGray1.color
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: SearchReactor) {
        let cateDS = RxCollectionViewSectionedAnimatedDataSource<SoomCategorySection>{ _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: SoomCategoryCollectionViewCell.reusableID, for: ip) as? SoomCategoryCollectionViewCell else { return .init() }
            cell.model = item
            return cell
        }
        
        Observable.just(getCategory())
            .map { [SoomCategorySection.init(header: "", items: $0)] }
            .bind(to: categoryCollectionView.rx.items(dataSource: cateDS))
            .disposed(by: disposeBag)
        
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    override func bindState(reactor: SearchReactor) {
        let sharedState = reactor.state.share(replay: 1)
        
        let soomDS = RxTableViewSectionedAnimatedDataSource<SoomSection>{ _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: SoomSearchResultCell.reusableID, for: ip) as? SoomSearchResultCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.sooms)
            .map { [SoomSection.init(header: "", items: $0)] }
            .bind(to: soomTableView.rx.items(dataSource: soomDS))
            .disposed(by: disposeBag)
        
    }
}

// MARK: - Extension
extension SearchVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: bound.width*0.2294, height: bound.width*0.2294)
    }
}

// MARK: - Method
private extension SearchVC{
    func getCategory() -> [SoomCategory] {
        return [
            .init(major: .web, color: UIColor(red: 1, green: 0.785, blue: 0.368, alpha: 1)),
            .init(major: .app, color: UIColor(red: 0.527, green: 0.631, blue: 1, alpha: 1)),
            .init(major: .backEnd, color: UIColor(red: 1, green: 0.527, blue: 0.527, alpha: 1)),
            .init(major: .game, color: UIColor(red: 0.792, green: 0.527, blue: 1, alpha: 1))
        ]
    }
}
