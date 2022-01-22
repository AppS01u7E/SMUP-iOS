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
    
    private let dateLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 18)
        $0.textColor = .systemGray4
        $0.textAlignment = .center
        $0.text = "FDSA"
    }
    private let todayLabel = UILabel().then {
        $0.font = UIFont(font: SMUPFontFamily.Inter.medium, size: 36)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = "asdf"
    }
    
    private let segControl = UISegmentedControl(items: ["일정표","급식표"]).then {
        $0.selectedSegmentTintColor = UIColor(red: 0.798, green: 0.596, blue: 1, alpha: 1)
        $0.selectedSegmentIndex = 0
    }
    
    private let clockView = ClockView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootContainer.frame = view.bounds
        rootContainer.flex.margin(view.safeAreaInsets)
        rootContainer.flex.layout()
    }
    // MARK: - UI
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayout() {
        rootContainer.flex.alignItems(.center).define { flex in
            flex.addItem().paddingTop(10).direction(.column).define { flex in
                flex.addItem(dateLabel)
                flex.addItem(todayLabel)
            }
            flex.addItem(segControl).height(38).top(4%).width(67%)
            flex.addItem(clockView).top(10%).width(bound.width*0.797).height(bound.width*0.797)
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
        (self.tabBarController as? MainTabbarVC)?.setFlaotyButtonHidden(false)
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
    }
    
    override func bindState(reactor: HomeReactor) {
        
    }
}
