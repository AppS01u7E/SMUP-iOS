//
//  SearchVC.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

final class SearchVC: baseVC<SearchReactor>{
    // MARK: - Properties
    private let searchTextField = SearchTextField(placeholder: "검색하실 SOOM 이름을 입력해주세요.")
    private let majorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        $0.register(SoomCategoryCollectionViewCell.self, forCellWithReuseIdentifier: SoomCategoryCollectionViewCell.reusableID)
        $0.collectionViewLayout = layout
    }
    
    // MARK: - UI
    override func setUp() {
        majorCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubViews(searchTextField, majorCollectionView)
    }
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(bound.height*0.023)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.11)
            $0.height.equalTo(40)
        }
        majorCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(searchTextField.snp.bottom).offset(13)
        }
    }
    override func configureVC() {
        
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: SearchReactor) {
       
    }
}

// MARK: - Extension
extension SearchVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: bound.width*0.2294, height: bound.width*0.2294)
    }
}
