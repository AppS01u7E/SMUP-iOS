//
//  TimeMapVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

final class TimeMapVC: baseVC<TimeMapReactor>{
    // MARK: - Properties
    private let mainView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let weekDayTableView = UITableView()
    
    // MARK: - UI
    override func setUp() {
    }
    override func addView() {
        view.addSubViews(mainView)
    }
    override func setLayout() {
        mainView.snp.makeConstraints {
            $0.height.equalTo(bound.height*0.8205)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    override func configureVC() {
        self.view.backgroundColor = .systemGray5
        
        
    }
    override func configureNavigation() {
        
    }
}
