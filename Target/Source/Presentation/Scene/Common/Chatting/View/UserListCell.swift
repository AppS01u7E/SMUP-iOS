//
//  UserListCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class UserListCell: baseTableViewCell<dummyUser>{
    // MARK: - Properties
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    private let nameLabel = UILabel()
    private let banButton = UIButton().then {
        $0.titleLabel?.textAlignment = .right
        $0.setTitleColor(.red, for: .normal)
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(profileImageView, nameLabel, banButton)
    }
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
            $0.width.height.equalTo(30)
        }
        banButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(2)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(banButton.snp.leading)
            $0.centerY.equalToSuperview()
        }
    }
    override func configureCell() {
        
    }
    override func bind(_ model: dummyUser) {
        profileImageView.kf.setImage(with: URL(string: model.profileImageUrl) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        nameLabel.text = model.username
    }
}
