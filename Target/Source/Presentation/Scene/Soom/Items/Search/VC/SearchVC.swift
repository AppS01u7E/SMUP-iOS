//
//  SearchVC.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

final class SearchVC: baseVC<SearchReactor>{
    // MARK: - Properties
    private let searchTextField = SearchTextField(placeholder: "검색하실 SOOM 이름을 입력해주세요.")
    private let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        $0.register(SoomCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SoomCategoryCollectionViewCell.reusableID)
        $0.collectionViewLayout = layout
    }
    
    // MARK: - UI
    override func setUp() {
        categoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubViews(searchTextField, categoryCollectionView)
    }
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(bound.height*0.023)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.11)
            $0.height.equalTo(40)
        }
        categoryCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(searchTextField.snp.bottom).offset(13)
        }
    }
    override func configureVC() {
        
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
