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
        
    }
}
