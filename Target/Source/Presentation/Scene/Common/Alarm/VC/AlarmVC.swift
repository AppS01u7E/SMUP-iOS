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
import RxGesture

final class AlarmVC: baseVC<AlarmReactor>{
    // MARK: - Properties
    private let alarmTableView = UITableView().then {
        $0.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.reusableID)
        $0.rowHeight = UIScreen.main.bounds.height*0.07924
        $0.allowsMultipleSelection = true
    }
    
    private let deleteButton = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: nil).then {
        $0.tintColor = .black
    }
    
    // MARK: - UI
    override func setUp() {
        self.alarmTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
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
        
        alarmTableView.rx.itemDeleted
            .asObservable()
            .map(\.row)
            .map(Reactor.Action.deleteOneAlarm)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension AlarmVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { [weak self] _, _, completion in
            guard let self = self else { return }
            Observable.just(indexPath.row)
                .map { Reactor.Action.deleteOneAlarm($0) }
                .bind(to: self.reactor.action)
                .disposed(by: self.disposeBag)
            completion(true)
        }
        delete.image = UIImage(systemName: "xmark")?.tintColor(.white)
        delete.backgroundColor = UIColor(red: 0.779, green: 0.779, blue: 0.779, alpha: 1)
        
        let check = UIContextualAction(style: .destructive, title: "체크") { [weak self]_ , _, completion in
            guard let self = self else { return }
            self.alarmTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            self.alarmTableView.delegate?.tableView?(self.alarmTableView, didSelectRowAt: indexPath)
            completion(false)
        }
        check.image = UIImage(systemName: "graduationcap")?.tintColor(.white)
        check.backgroundColor = UIColor(red: 0.878, green: 0.804, blue: 0.973, alpha: 1)
        
        let config = UISwipeActionsConfiguration(actions: [delete, check])
        
        return config
    }
}
