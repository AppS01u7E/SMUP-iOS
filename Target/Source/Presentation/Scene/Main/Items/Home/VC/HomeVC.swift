//
//  HomeVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxCocoa
import RxViewController
import PinLayout
import FlexLayout

final class HomeVC: baseVC<HomeReactor>{
    // MARK: - Properties
    private let alarmButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "bell")?.tintColor(.black)
    }
    
    private let rootContainer = UIView()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let dateLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 18)
        $0.textColor = .systemGray4
        $0.textAlignment = .center
        $0.text = "\(Date().convertKorea().toString(.custom("yyyy.MM.dd")))"
    }
    private let todayLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 36)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = "Today"
    }
    
    private let segControl = UISegmentedControl(items: ["일정표","급식표"]).then {
        $0.selectedSegmentTintColor = UIColor(red: 0.798, green: 0.596, blue: 1, alpha: 1)
        $0.selectedSegmentIndex = 0
    }
    private let clockView = ClockView()
    private let scheduleView = ScheduleView()
    
    private let breakfastLabel = MealLabel(part: .breakfast).then {
        $0.setDetailMeal(content: "fdzz")
        $0.isHidden = true
    }
    private let lunchLabel = MealLabel(part: .lunch).then {
        $0.setDetailMeal(content: "fdzz\nfdzz")
        $0.isHidden = true
    }
    private let dinnerLabel = MealLabel(part: .dinner).then {
        $0.setDetailMeal(content: "fdzz")
        $0.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin.all()
        rootContainer.pin.top().left().right().bottom()
        rootContainer.flex.layout()
        scrollView.contentSize = rootContainer.frame.size
    }
    // MARK: - UI
    override func addView() {
        scrollView.addSubViews(rootContainer)
        view.addSubViews(scrollView)
    }
    override func setLayout() {
        rootContainer.flex.alignItems(.center).define { flex in
            flex.addItem().paddingTop(10).direction(.column).define { flex in
                flex.addItem(dateLabel)
                flex.addItem(todayLabel)
            }
            flex.addItem(segControl).height(38).top(4%).width(67%)
            flex.addItem(clockView).top(10%).width(bound.width*0.797).height(bound.width*0.797)
            flex.addItem(scheduleView).top(15%).width(85%).height(95)
            flex.addItem().top(5%).horizontally(0).bottom(0).width(100%).height(60%).justifyContent(.spaceEvenly).alignItems(.center).define { flex in
                flex.addItem(breakfastLabel).width(85%).minHeight(90).maxHeight(300)
                flex.addItem(lunchLabel).width(85%).minHeight(90).maxHeight(300)
                flex.addItem(dinnerLabel).width(85%).minHeight(90).maxHeight(300)
            }
        }
    }
    override func configureVC() {
        
    }
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "SMUP")
        self.navigationItem.rightBarButtonItem = alarmButton

    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clockView.start()
    }
    
    
    // MARK: - Reactor
    override func bindAction(reactor: HomeReactor) {
        
    }
    
    override func bindView(reactor: HomeReactor) {
        alarmButton.rx.tap
            .do(onNext: { [weak self] _ in
                let back: UIBarButtonItem = .init(title: "", style: .plain, target: self, action: nil)
                back.tintColor = .black
                self?.navigationItem.backBarButtonItem = back
            })
            .map { _ in Reactor.Action.alarmButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        segControl.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.segControl.selectedSegmentIndex == 0{
                    [owner.clockView, owner.scheduleView].forEach{ $0.flex.display(.flex); $0.isHidden = false }
                    [owner.breakfastLabel, owner.lunchLabel, owner.dinnerLabel].forEach{ $0.flex.display(.none); $0.isHidden = true }
                }else{
                    [owner.clockView, owner.scheduleView].forEach{ $0.flex.display(.none); $0.isHidden = true }
                    [owner.breakfastLabel, owner.lunchLabel, owner.dinnerLabel].forEach{ $0.flex.display(.flex); $0.isHidden = false}
                }
                self.rootContainer.flex.layout()
            })
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: HomeReactor) {
        scheduleView.bind(.init(date: Date(), perio: 1, name: "프로그래밍", content: ["앱 프로그래밍 과제"], reference: "2학년 2반 Chat에서 김성훈님이 공지하셨습니다"))
    }
}
