//
//  SOOMStoryCollectionViewCell.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/02/20.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import PinLayout

final class SOOMStoryCollectionViewCell : baseCollectionViewCell<SoomHeaderModel> { 
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.NotoSansKR.medium, size: 13)
        $0.textColor = .white
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.NotoSansKR.regular, size: 11)
        $0.textColor = .white
        
    }
    
    private var storyImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .white
    }
    //MARK: - UI
    override func addView() {
        addSubViews(titleLabel, descriptionLabel, storyImageView)
    }
    
    override func setLayoutSubViews() {
        storyImageView.pin.top(7).left(10).height(54).width(34)
        titleLabel.pin.top(16).left(50).height(14).width(100%)
        descriptionLabel.pin.left(50).top(32).height(14).width(100%)
        
    }
    
    override func configureCell() {
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    override func bind(_ model: SoomHeaderModel) {
        self.backgroundColor = model.color
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        storyImageView.image = UIImage(named: "\(model.imageUrl)")
    }
    
    
}
