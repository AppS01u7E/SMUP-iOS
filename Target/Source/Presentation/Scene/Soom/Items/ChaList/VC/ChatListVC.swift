//
//  ChatListVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import PinLayout
import Then
import RxSwift
import RxCocoa
import RxDataSources

final class ChatListVC: baseVC<ChatListReactor>{
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "검색하실 채팅방을 입력해주세요."
        $0.obscuresBackgroundDuringPresentation = false
    }
    private let chatListTableView = UITableView().then {
        $0.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.reusableID)
        $0.rowHeight = 72
        $0.separatorStyle = .none
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.tabBarController as? SoomTabbarVC)?.setFlaotyButtonHidden(false)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(chatListTableView)
    }
    override func setLayout() {
        chatListTableView.pin.vertically(view.pin.safeArea).horizontally(8.4%)
    }
    override func configureVC() {
        view.backgroundColor = SMUPAsset.smupGray1.color
    }
    override func configureNavigation() {
        self.navigationItem.searchController = searchController
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: ChatListReactor) {
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: ChatListReactor) {
        searchController.searchBar.rx.text
            .orEmpty
            .map(Reactor.Action.updateQuery)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        chatListTableView.rx.modelSelected(ChatRoom.self)
            .withUnretained(self)
            .do(onNext: { owner, item in
                let back: UIBarButtonItem = .init(title: item.name, style: .plain, target: owner, action: nil)
                back.tintColor = SMUPAsset.smupGray6.color
                owner.navigationItem.backBarButtonItem = back
            })
            .map { Reactor.Action.chattingDidTap($0.1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
            
    }
    override func bindState(reactor: ChatListReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let dataSrouces = RxTableViewSectionedReloadDataSource<ChatListSection>{ _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: ChatListCell.reusableID, for: ip) as? ChatListCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.chatLists)
            .map{
                if reactor.currentState.query != ""{
                    return $0.filter{ $0.name.contains(reactor.currentState.query) }
                }
                return $0
            }
            .map { [ChatListSection(header: "", items: $0)] }
            .bind(to: chatListTableView.rx.items(dataSource: dataSrouces))
            .disposed(by: disposeBag)
    }
}
