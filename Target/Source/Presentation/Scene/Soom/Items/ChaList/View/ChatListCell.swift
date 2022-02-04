//
//  ChatListCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit
import Kingfisher

final class ChatListCell: baseTableViewCell<ChatList>{
    // MARK: - Properties
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 26
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    private let nameLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 14)
        $0.textColor = .black
    }
    private let recentMessageLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 12)
        $0.textColor = .black.withAlphaComponent(0.73)
    }
    private let firstStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    private let recentDateLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 13)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    private let alarmCountLabel = UILabel().then {
        $0.frame = .init(x: 0, y: 0, width: 17, height: 17)
        $0.font = UIFont(font: SMUPFontFamily.Inter.light, size: 9)
        $0.backgroundColor = UIColor(red: 1, green: 0.438, blue: 0.314, alpha: 0.69)
        $0.layer.cornerRadius = 8.5
        $0.clipsToBounds = true
        $0.textColor = .white
        $0.isHidden = true
        $0.textAlignment = .center
    }
    
    // MARK: - UI
    override func addView() {
        firstStack.addArrangeSubviews(nameLabel, recentMessageLabel)
        addSubViews(profileImageView, firstStack, recentDateLabel, alarmCountLabel)
    }
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.height.equalTo(52)
        }
        recentDateLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.centerY)
            $0.trailing.equalToSuperview().inset(5)
        }
        alarmCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.centerY)
            $0.trailing.equalToSuperview().inset(5)
            $0.width.height.equalTo(17)
        }
        firstStack.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(recentDateLabel.snp.leading).priority(.high)
            $0.centerY.equalToSuperview()
        }
    }
    override func configureCell() {
        self.selectionStyle = .none
    }
    override func bind(_ model: ChatList) {
        profileImageView.kf.setImage(with: URL(string: model.profileImageUrl) ?? .none,
                                     placeholder: UIImage(),
                                     options: [.cacheMemoryOnly])
        nameLabel.text = model.name
        recentMessageLabel.text = model.recentMessage
        recentDateLabel.text = model.recentDate.convertCustomString()
        if model.alarmCount != 0{
            alarmCountLabel.isHidden = false
            alarmCountLabel.text = "\(model.alarmCount)"
        }
    }
}
