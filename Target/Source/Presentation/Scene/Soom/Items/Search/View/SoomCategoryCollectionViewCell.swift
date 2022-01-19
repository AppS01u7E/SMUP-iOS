//
//  SoomCategoryCollectionViewCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import Then

final class SoomCategoryCollectionViewCell: baseCollectionViewCell<SoomCategory>{
    // MARK: - Properties
    private let majorLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 12)
        $0.textColor = .white
    }
    private let iconImageView = UIImageView()
    
    // MARK: - UI
    override func addView() {
        addSubViews(majorLabel, iconImageView)
    }
    override func setLayout() {
        majorLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(14)
        }
        iconImageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(7)
        }
    }
    override func configureCell() {
        self.layer.cornerRadius = 18
        self.clipsToBounds = true
    }
    override func bind(_ model: SoomCategory) {
        self.backgroundColor = model.color
        majorLabel.text = model.major.rawValue
        var image: UIImage = UIImage()
        switch model.major{
        case .web:
            image = UIImage(systemName: "pc") ?? .init()
        case .app:
            image = UIImage(systemName: "iphone") ?? .init()
        case .backEnd:
            image = UIImage(systemName: "server.rack") ?? .init()
        case .game:
            image = UIImage(systemName: "gamecontroller") ?? .init()
        }
        iconImageView.image = image.tintColor(.white).downSample(size: .init(width: 20, height: 20))
    }
}
