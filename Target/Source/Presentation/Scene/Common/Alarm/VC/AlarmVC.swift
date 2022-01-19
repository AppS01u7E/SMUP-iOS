//
//  AlarmVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

final class AlarmVC: baseVC<AlarmReactor>{
    // MARK: - Properties
    private let alarmTableView = UITableView().then {
        $0.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.reusableID)
        $0.rowHeight = UIScreen.main.bounds.height*0.07924
//        $0.allowsMultipleSelection = true
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
        bind(reactor: reactor)
        view.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
    }
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "알림")
        self.navigationItem.rightBarButtonItem = deleteButton
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: AlarmReactor) {
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: AlarmReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let alarmDS = RxTableViewSectionedReloadDataSource<AlarmSection>{ ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: AlarmCell.reusableID, for: ip) as? AlarmCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.alarms)
            .map { [AlarmSection.init(header: "", items: $0)] }
            .bind(to: alarmTableView.rx.items(dataSource: alarmDS))
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: AlarmReactor) {
        deleteButton.rx.tap
            .map { _ in
                var items: [Int] = []
                self.alarmTableView.indexPathsForSelectedRows?.forEach{ items.append($0.row) }
                return items
            }
            .map { Reactor.Action.deleteButtonDidTap($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.alarmTableView.rx.itemDeleted
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
}
