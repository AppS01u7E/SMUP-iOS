//
//  MealView.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class MealLabel: UIView{
    // MARK: - Init
    private let contentLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 14)
        $0.numberOfLines = 0
    }
    private let part: MealPart
    init(part: MealPart){
        self.part = part
        super.init(frame: .zero)
        addView()
        setLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - OpenMethod
    public func setDetailMeal(content: String){
        let str = NSMutableAttributedString(string: "\(part.rawValue)\n\(content)")
        str.setColorForText(textToFind: part.rawValue, withColor: SMUPAsset.smupMain2.color)
        str.setFontForText(textToFind: part.rawValue, withFont: UIFont(font: SMUPFontFamily.Inter.bold, size: 24) ?? .init())
        self.contentLabel.attributedText = str
        self.setDashedBorder(color: .systemGray5)
    }
}

// MARK: - UI
private extension MealLabel{
    func addView(){
        addSubViews(contentLabel)
    }
    func setLayout(){
        contentLabel.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview().inset(15)
        }
    }
    func configureView(){
        let str = NSMutableAttributedString(string: part.rawValue)
        str.setColorForText(textToFind: part.rawValue, withColor: SMUPAsset.smupMain2.color)
        str.setFontForText(textToFind: part.rawValue, withFont: UIFont(font: SMUPFontFamily.Inter.bold, size: 24) ?? .init())
        contentLabel.attributedText = str
    }
}
