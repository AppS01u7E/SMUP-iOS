//
//  SelectedDateLabel.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit
import SwiftDate

final class SelectedDateLabel: UILabel {
    // MARK: - Properties
    private let detailDateLabel = UILabel().then {
        $0.textColor = .gray
        $0.text = "ASDF"
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 18)
    }
    
    private var selectedDate = Date()
    
    private let formatter = DateFormatter().then {
        $0.dateFormat = "yyyy.MM.dd"
        $0.locale = Locale(identifier: "KO_KR")
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureView()
        self.text = "ASDF"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Open Method
    public func bindDate(date: Date){
        self.selectedDate = date
        if selectedDate.isToday{
            self.text = "Today"
        }
        else if selectedDate.isBeforeDate(Date(), granularity: .day){
            self.text = "\(Date().difference(in: .day, from: selectedDate) ?? 0)일 전"
            
        }
        else if selectedDate.isAfterDate(Date(), granularity: .day){
            self.text = "\((Date().difference(in: .day, from: selectedDate) ?? 0)+1)일 후"
        }
        
        self.detailDateLabel.text = formatter.string(from: selectedDate)
    }
}

// MARK: - Method
private extension SelectedDateLabel{
    func addView(){
        addSubViews(detailDateLabel)
    }
    func setLayout(){
        detailDateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(-8)
        }
        
    }
    func configureView(){
        self.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 36)
    }
}
