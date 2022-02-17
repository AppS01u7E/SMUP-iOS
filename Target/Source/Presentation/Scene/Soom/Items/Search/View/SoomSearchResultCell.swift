//
//  SoomCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import PinLayout
import FlexLayout

final class SoomSearchResultCell: baseTableViewCell<Soom>{
    // MARK: - Properties
    private let view = UIView().then {
        $0.layer.cornerRadius = 17
        $0.backgroundColor = SMUPAsset.smupGray1.color
    }
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 13)
        $0.textColor = SMUPAsset.smupGray6.color
    }
    private let descriptionsLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 12)
        $0.textColor = SMUPAsset.smupGray6.color.withAlphaComponent(0.65)
    }
    private let postButton = UIButton().then {
        $0.setTitle("게시물 보기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 9)
        $0.backgroundColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    private let chatButton = UIButton().then {
        $0.setTitle("채팅 하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 9)
        $0.backgroundColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    
    // MARK: - UI
    override func addView() {
    }
    override func setLayoutSubViews() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    override func setLayout() {
        contentView.flex.padding(13).define { flex in
            flex.addItem(view).padding(13).define { flex in
                flex.addItem(titleLabel).width(100%)
                flex.addItem(descriptionsLabel).width(100%).marginVertical(8)
                flex.addItem().direction(.row).width(100%).define { flex in
                    flex.addItem(postButton).width(72).height(21)
                    flex.addItem(chatButton).width(57).height(21).marginLeft(12)
                }
            }
        }
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        setLayoutSubViews()
        return contentView.frame.size
    }
    override func configureCell() {
        self.selectionStyle = .none
        view.applyShadow(color: SMUPAsset.smupGray6.color, radius: 4, offSet: .init(width: 0, height: 2), opacity: 1)
        
    }
    override func bind(_ model: Soom) {
        titleLabel.text = model.name
        titleLabel.flex.markDirty()
        descriptionsLabel.text = model.description
        descriptionsLabel.flex.markDirty()
    }
}
