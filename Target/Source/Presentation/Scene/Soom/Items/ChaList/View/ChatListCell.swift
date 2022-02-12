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
import PinLayout
import FlexLayout
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
    }
    override func setLayoutSubViews() {
        contentView.flex.layout(mode: .fitContainer)
    }
    override func setLayout() {
        contentView.flex.marginVertical(10).direction(.row).define { flex in
            flex.addItem(profileImageView).size(52)
            flex.addItem().marginLeft(10).alignItems(.start).grow(1).define { flex in
                flex.addItem(nameLabel)
                flex.addItem(recentMessageLabel)
            }
            flex.addItem().alignSelf(.end).height(100%).alignItems(.center).define { flex in
                flex.addItem(recentDateLabel).alignSelf(.end)
                flex.addItem(alarmCountLabel).alignSelf(.end).size(17)
            }
        }
    }
    override func configureCell() {
        
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        setLayoutSubViews()
        return contentView.frame.size
    }
    override func bind(_ model: ChatList) {
        profileImageView.kf.setImage(with: URL(string: model.profileImageUrl) ?? .none,
                                     placeholder: UIImage(),
                                     options: [.cacheMemoryOnly])
        nameLabel.text = model.name
        nameLabel.flex.markDirty()
        recentMessageLabel.text = model.recentMessage
        recentMessageLabel.flex.markDirty()
        recentDateLabel.text = model.recentDate.convertCustomString()
        recentDateLabel.flex.markDirty()
        if model.alarmCount != 0{
            alarmCountLabel.isHidden = false
            alarmCountLabel.text = "\(model.alarmCount)"
        }
    }
}
