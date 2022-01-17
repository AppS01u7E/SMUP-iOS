//
//  TimeMapDetailCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class TimeMapDetailCell: baseCollectionViewCell<TimeMap>{
    // MARK: - Properties
    private let dateLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 20)
    }
    private let perioLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 19)
    }
    private let dateStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    private let contentLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 12)
    }
    
    private let referenceLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(font: SMUPFontFamily.Inter.semiBold, size: 12)
    }
    
    // MARK: - UI
    override func addView() {
        dateStack.addArrangeSubviews(dateLabel, perioLabel)
        addSubViews(dateStack, contentLabel, referenceLabel)
    }
    override func setLayout() {
        
    }
    override func configureCell() {
        
    }
    
    override func bind(_ model: TimeMap) {
        
    }
}
