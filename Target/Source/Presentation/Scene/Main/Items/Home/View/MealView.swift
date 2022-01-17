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
        let str = NSMutableAttributedString(attributedString: contentLabel.attributedText ?? .init())
        str.append(.init(string: "\(content)\n"))
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
        var partString = ""
        switch part{
        case .breakfast:
            partString = "아침"
        case .lunch:
            partString = "점심"
        case .dinner:
            partString = "저녁"
        }
        let str = NSMutableAttributedString(string: "\(partString)")
        str.setColorForText(textToFind: partString, withColor: SMUPAsset.smupMain2.color)
        str.setFontForText(textToFind: partString, withFont: UIFont(font: SMUPFontFamily.Inter.bold, size: 24) ?? .init())
        contentLabel.attributedText = str
    }
}
