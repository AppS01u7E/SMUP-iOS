//
//  ScheduleTableView.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class ScheduleTableViewCell: baseTableViewCell<TimeMap>{
    // MARK: - Properties
    private let view = UIView()
    private let timeLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .right
    }
    
    private let perioLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.bold, size: 14)
    }
    private let contentLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 12)
        $0.numberOfLines = 0
        $0.textColor = .gray
    }
    private let referenceLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.regular, size: 8)
    }
    private let scheduleStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    private let scheduleView = UIView().then {
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = 10
    }
    // MARK: - Metric
    struct Metric{
        static let horizontalPadding = 20
        static let scheduleHorizontalPadding = 8
        static let scheduleVerticalPadding = 10
    }
    
    override func layoutSubviews() {
        setLayout()
        configureCell()
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(view)
        scheduleStack.addArrangeSubviews(perioLabel, contentLabel, referenceLabel)
        scheduleView.addSubViews(scheduleStack)
        view.addSubViews(timeLabel, scheduleView)
    }
    
    override func setLayout() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(3)
            $0.top.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(bound.width*0.12)
        }
        scheduleStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Metric.scheduleHorizontalPadding)
            $0.leading.trailing.equalToSuperview().inset(Metric.scheduleVerticalPadding)
        }
        scheduleView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Metric.horizontalPadding)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(timeLabel.snp.trailing).offset(bound.width*0.05)
            $0.trailing.equalToSuperview().inset(3)
        }
    }
    override func configureCell() {
        self.layer.cornerRadius = 10
    }
    override func bind(_ model: TimeMap) {
        let perio = model.perio.convertPerio()
        let start = model.perio.convertStartTime()
        let end = model.perio.convertEndTime()
        
        let str = NSMutableAttributedString(string: "\(perio)\n\(start)\n\(end)")
        str.setColorForText(textToFind: perio, withColor: .systemGray3)
        str.setFontForText(textToFind: perio, withFont: .init(font: SMUPFontFamily.Inter.bold, size: 13) ?? .init())
        
        str.setColorForText(textToFind: start, withColor: .black)
        str.setFontForText(textToFind: start, withFont: .init(font: SMUPFontFamily.Inter.semiBold, size: 16) ?? .init())
        
        str.setColorForText(textToFind: end, withColor: .systemGray5)
        str.setFontForText(textToFind: end, withFont: .init(font: SMUPFontFamily.Inter.medium, size: 12) ?? .init())
        timeLabel.attributedText = str
        
        perioLabel.text = "\(model.perio)교시 \(model.name)"
        let conStr = NSMutableAttributedString()
        model.content.forEach{ con in
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "circle.fill")?.tintColor(.systemGray3).downSample(size: .init(width: 3.5, height: 3.5))
            conStr.append(.init(string: "\t"))
            conStr.append(.init(attachment: imageAttachment))
            conStr.append(.init(string: "\(con)\n"))
        }
        contentLabel.attributedText = conStr
        
        referenceLabel.text = model.reference
        
    }
}
