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
        $0.backgroundColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    private let chatButton = UIButton().then {
        $0.setTitle("채팅 하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
        $0.layer.cornerRadius = 10
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
    private let deco = SoomDeco()
    
    // MARK: - UI
    override func addView() {
        buttonStack.addArrangeSubviews(postButton, chatButton)
        mainStack.addArrangeSubviews(titleLabel, descriptionsLabel, buttonStack)
        addSubViews(mainStack, deco)
    }
    override func setLayout() {
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(18)
        }
        deco.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.top)
            $0.centerX.equalTo(self.snp.trailing)
        }
    }
    override func configureCell() {
        self.layer.cornerRadius = 17
        self.addShadow(offset: .init(width: 4, height: 4), color: .black, opacity: 1, radius: 20)
    }
}
