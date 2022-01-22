//
//  DrawerCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Then

final class DrawerCell: baseCollectionViewCell<String>{
    // MARK: - Properties
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(imageView)
    }
    override func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func bind(_ model: String) {
        imageView.kf.setImage(with: URL(string: model) ?? .none,
                              placeholder: UIImage(),
                              options: [])
    }
}
