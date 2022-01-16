//
//  HomeVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxCocoa

final class HomeVC: baseVC<HomeReactor>{
    // MARK: - Properties
    private let beforeDayButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left")?.tintColor(.black),
                    for: .normal)
        
    }
    private let selectedDayLabel = SelectedDateLabel()
    private let afterDayButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right")?.tintColor(.black),
                    for: .normal)
    }
    private let dayStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 35
    }
    
    private let checkScheduleButton = CheckScheduleButton(title: "시간표 및 일정 확인")
    
    private let breakfastLabel = UILabel()
    private let lunchLabel = UILabel()
    private let dinnerLabel = UILabel()
    private let mealStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 25
    }
    
    private let alarmButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "bell")?.tintColor(.black)
    }
    
    // MARK: - UI
    override func addView() {
        dayStack.addArrangeSubviews(beforeDayButton, selectedDayLabel, afterDayButton)
        mealStack.addArrangeSubviews(breakfastLabel, lunchLabel, dinnerLabel)
        view.addSubViews(dayStack, mealStack, checkScheduleButton)
    }
    override func setLayout() {
        beforeDayButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
        }
        afterDayButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
        }
        dayStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(bound.height*0.1)
            $0.centerX.equalToSuperview()
        }
        checkScheduleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dayStack.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.1277)
            $0.height.equalTo(bound.height*0.1371)
        }
        
    }
    override func configureVC() {
        
    }
    override func configureNavigation() {
        self.navigationItem.title = "SMUP"
        
        self.navigationItem.rightBarButtonItem = alarmButton
    }
    
    
    // MARK: - Reactor
    override func bindView(reactor: HomeReactor) {
        beforeDayButton.rx.tap
            .map { _ in Reactor.Action.minusDay }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        afterDayButton.rx.tap
            .map { _ in Reactor.Action.plusDay }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: HomeReactor) {
        let sharedState = reactor.state.share(replay: 1)
        
        sharedState
            .map(\.selectedDate)
            .subscribe(onNext: { [weak self] in
                self?.selectedDayLabel.bindDate(date: $0)
            })
            .disposed(by: disposeBag)
    }
}
