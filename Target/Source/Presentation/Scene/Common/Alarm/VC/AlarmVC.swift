//
//  AlarmVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

final class AlarmVC: baseVC<AlarmReactor>{
    // MARK: - Properties
    private let alarmTableView = UITableView().then {
        $0.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.reusableID)
        $0.rowHeight = UIScreen.main.bounds.height*0.07924
    }
    
    private let deleteButton = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: nil).then {
        $0.tintColor = .black
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(alarmTableView)
    }
    override func setLayout() {
        alarmTableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(bound.height*0.149)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.084)
        }
    }
    override func configureVC() {
        view.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
    }
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "알림")
        self.navigationItem.rightBarButtonItem = deleteButton
    }
}
