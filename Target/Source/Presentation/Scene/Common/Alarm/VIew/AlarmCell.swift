//
//  AlarmCell.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class AlarmCell: baseTableViewCell<Alarm>{
    // MARK: - Properties
    private let contentLabel = UILabel()
    private let dateLabel = UILabel()
    
    override func awakeFromNib() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.878, green: 0.804, blue: 0.973, alpha: 1)
        selectedBackgroundView = backgroundView
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(contentLabel, dateLabel)
    }
    override func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(5)
        }
        contentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(5)
            $0.trailing.equalTo(dateLabel.snp.leading).priority(.low)
        }
    }
    override func configureCell() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.878, green: 0.804, blue: 0.973, alpha: 1)
        selectedBackgroundView = backgroundView
    }
    override func bind(_ model: Alarm) {
        contentLabel.text = model.content
        dateLabel.text = model.date.toString(.custom("MM:dd"))
    }
}
