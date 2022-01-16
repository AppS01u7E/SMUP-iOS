//
//  HomeVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

final class HomeVC: baseVC<HomeReactor>{
    // MARK: - Properties
    private let beforeDayButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    }
    private let selectedDayLabel = SelectedDateLabel()
    private let afterDayButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    }
    private let dayStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 35
    }
    private let breakfastLabel = UILabel()
    private let lunchLabel = UILabel()
    private let dinnerLabel = UILabel()
    private let mealStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 25
    }
    
    // MARK: - UI
    override func addView() {
        dayStack.addArrangeSubviews(beforeDayButton, selectedDayLabel, afterDayButton)
        mealStack.addArrangeSubviews(breakfastLabel, lunchLabel, dinnerLabel)
        view.addSubViews(dayStack, mealStack)
    }
    override func setLayout() {
        dayStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.centerX.equalToSuperview()
        }
    }
    override func configureVC() {
        
    }
}
