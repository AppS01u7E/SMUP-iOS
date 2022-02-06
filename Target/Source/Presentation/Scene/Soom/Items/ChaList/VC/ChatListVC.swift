//
//  ChatListVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxDataSources

final class ChatListVC: baseVC<ChatListReactor>{
    // MARK: - Properties
    private let searchTextField = SearchTextField(placeholders: "검색하실 채팅방을 입력해주세요.")
    private let chatListTableView = UITableView().then {
        $0.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.reusableID)
        $0.rowHeight = 72
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.tabBarController as? SoomTabbarVC)?.setFlaotyButtonHidden(false)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(searchTextField, chatListTableView)
    }
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(bound.height*0.023)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.11)
            $0.height.equalTo(40)
        }
        chatListTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(bound.height*0.024)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.084)
            $0.bottom.equalToSuperview()
        }
    }
    override func configureVC() {
        
    }
    override func configureNavigation() {
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: ChatListReactor) {
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: ChatListReactor) {
        searchTextField.rx.text
            .orEmpty
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .map { Reactor.Action.updateQuery($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        chatListTableView.rx.modelSelected(ChatList.self)
            .withUnretained(self)
            .do(onNext: { owner, item in
                let back: UIBarButtonItem = .init(title: item.name, style: .plain, target: owner, action: nil)
                back.tintColor = .black
                owner.navigationItem.backBarButtonItem = back
            })
            .map { Reactor.Action.chattingDidTap($0.1.id) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
            
    }
    override func bindState(reactor: ChatListReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let dataSrouces = RxTableViewSectionedReloadDataSource<ChatListSection>{ ds, tv, ip, item in
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