//
//  SoomCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class SoomCell: baseTableViewCell<Soom>{
    // MARK: - Properties
    private let view = UIView().then {
        $0.layer.cornerRadius = 17
        $0.backgroundColor = .white
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 13)
        $0.textColor = .black
    }
    private let descriptionsLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 12)
        $0.textColor = .black.withAlphaComponent(0.65)
    }
    private let postButton = UIButton().then {
        $0.setTitle("게시물 보기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 9)
        $0.backgroundColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private let chatButton = UIButton().then {
        $0.setTitle("채팅 하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 9)
        $0.backgroundColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private let buttonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
    }
    private let mainStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
    }
    
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(view)
        buttonStack.addArrangeSubviews(postButton, chatButton)
        mainStack.addArrangeSubviews(titleLabel, descriptionsLabel, buttonStack)
        view.addSubViews(mainStack)
    }
    override func setLayout() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(13)
        }
        postButton.snp.makeConstraints {
            $0.width.equalTo(59)
            $0.height.equalTo(11)
        }
        chatButton.snp.makeConstraints {
            $0.width.equalTo(54)
            $0.height.equalTo(11)
        }
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(18)
        }
    }
    override func configureCell() {
        self.selectionStyle = .none
        view.applyShadow(color: .lightGray, radius: 4, offSet: .init(width: 0, height: 2), opacity: 1)
        
    }
    override func bind(_ model: Soom) {
        titleLabel.text = model.name
        descriptionsLabel.text = model.description
    }
}
