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

final class SelectedDateLabel: UILabel {
    // MARK: - Properties
    private let detailDateLabel = UILabel().then {
        $0.textColor = .gray
        
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Open Method
    public func dateDidChange(date: Date){
        
    }
}

// MARK: - Method
private extension SelectedDateLabel{
    func addView(){
        addSubViews(detailDateLabel)
    }
    func setLayout(){
        detailDateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    func configureView(){
        
    }
}
