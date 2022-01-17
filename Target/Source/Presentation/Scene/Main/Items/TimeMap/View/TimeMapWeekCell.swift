//
//  TimeMapWeekCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import SwiftDate
import Then

final class TimeMapWeekCell: baseCollectionViewCell<WeekDay> {
    // MARK: - Properties
    private let weekLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 26)
    }
    private let dayLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 18)
    }
    private let todayLabel = UILabel().then {
        $0.isHidden = true
        $0.textColor = .lightGray
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 14)
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(weekLabel, dayLabel, todayLabel)
    }
    override func setLayout() {
        weekLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(weekLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        todayLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.top).offset(-3)
        }
    }
    override func configureCell() {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    override func bind(_ model: WeekDay) {
        self.dayLabel.text = "\(model.rawValue-1)"
        switch model{
        case .monday:
            weekLabel.text = "M"
        case .tuesday:
            weekLabel.text = "T"
        case .wednesday:
            weekLabel.text = "W"
        case .thursday:
            weekLabel.text = "T"
        case .friday:
            weekLabel.text = "F"
        case .saturday:
            weekLabel.text = "S"
        case .sunday:
            weekLabel.text = "S"
            dayLabel.text = "7"
        }
    }
    
    // MARK: - OpenMethod
    public func didSelectItem() {
        print("sel")
        self.backgroundColor = .black
        self.weekLabel.textColor = .white
        self.dayLabel.textColor = .white
    }
    public func didDeSelectItem(){
        print("Desel")
        self.backgroundColor = .clear
        self.weekLabel.textColor = .black
        self.dayLabel.textColor = .lightGray
    }
}
