//
//  SearchTextField.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit

final class SearchTextField: UITextField{
    // MARK: - Properties
    private let searchImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")?.downSample(size: .init(width: 12, height: 12)).tintColor(.gray)
    }
    
    // MARK: - Init
    init(placeholders: String){
        super.init(frame: .zero)
        self.placeholder = placeholders
        addView()
        setLayout()
        configureTF()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
private extension SearchTextField{
    func addView(){
        addSubViews(searchImageView)
    }
    func setLayout(){
        searchImageView.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.leading)
            $0.centerY.equalToSuperview()
        }
    }
    func configureTF(){
        self.applyUnderline()
    }
}
