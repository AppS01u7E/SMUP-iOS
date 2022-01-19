//
//  ChattingSettingSideVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import SideMenu
import UIKit
import RxSwift
import SnapKit
import RxDataSources

final class ChattingSettingSideVC: baseVC<ChattingReactor>{
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.text = "채팅방 설정"
        $0.textColor = .black
    }
    
    private let separatorLine = UIView().then {
        $0.backgroundColor = UIColor(red: 0.486, green: 0.486, blue: 0.486, alpha: 1)
    }
    
    private let memberLabel = UILabel().then {
        $0.text = "멤버"
        $0.textColor = .black
    }
    
    private let userListTableView = UserListTableView().then {
        $0.register(UserListCell.self, forCellReuseIdentifier: UserListCell.reusableID)
        $0.separatorStyle = .none
        $0.rowHeight = 38
    }
    
    
    
    private let secondSeparatorLine = UIView().then {
        $0.backgroundColor = UIColor(red: 0.486, green: 0.486, blue: 0.486, alpha: 1)
    }
    
    private let drawerLabel = UILabel().then {
        $0.text = "서랍장"
        $0.textColor = .black
    }
    private let allViewButton = UIButton().then {
        $0.setTitle("모두 보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.textAlignment = .right
        $0.setImage(.init(systemName: "chevron.right")?.tintColor(.black).downSample(size: .init(width: 7, height: 7)), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    private let drawerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.showsHorizontalScrollIndicator = false
        $0.register(DrawerCell.self, forCellWithReuseIdentifier: DrawerCell.reusableID)
        $0.collectionViewLayout = layout
    }
    
    private let bottomView = UIView()
    private let exitButton = UIButton().then {
        $0.setImage(.init(systemName: "rectangle.portrait.and.arrow.right")?.tintColor(.init(red: 0.588, green: 0.333, blue: 1, alpha: 1)).downSample(size: .init(width: 10, height: 10)), for: .normal)
    }
    private let alarmButton = UIButton().then {
        $0.setImage(.init(systemName: "bell")?.tintColor(.init(red: 0.588, green: 0.333, blue: 1, alpha: 1)).downSample(size: .init(width: 10, height: 10)), for: .normal)
    }
    private let bottomStack = UIStackView()
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - UI
    override func setUp() {
        drawerCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubViews(scrollView, bottomView)
        scrollView.addSubViews(titleLabel, separatorLine, memberLabel, userListTableView, secondSeparatorLine, drawerLabel, allViewButton, drawerCollectionView)
        bottomStack.addArrangeSubviews(exitButton, alarmButton)
        bottomView.addSubViews(bottomStack)
    }
    override func setLayout() {
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.greaterThanOrEqualTo(50)
        }
        bottomStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(bound.width*0.048)
        }
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().priority(.low)
        }
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(bound.width*0.048)
        }
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(bound.height*0.0111)
            $0.width.equalTo(bound.width*0.685 - bound.width*0.1256)
            $0.leading.equalToSuperview().inset(bound.width*0.048)
            $0.height.equalTo(1)
        }
        drawerLabel.snp.makeConstraints {
            $0.top.equalTo(separatorLine.snp.bottom).offset(bound.height*0.0111)
            $0.leading.equalTo(separatorLine)
        }
        allViewButton.snp.makeConstraints {
            $0.top.equalTo(drawerLabel)
            $0.trailing.equalTo(separatorLine)
        }
        drawerCollectionView.snp.makeConstraints {
            $0.top.equalTo(drawerLabel.snp.bottom).offset(bound.height*0.0111)
            $0.leading.trailing.equalTo(separatorLine)
        }
        secondSeparatorLine.snp.makeConstraints {
            $0.top.equalTo(drawerCollectionView.snp.bottom).offset(bound.height*0.0111)
            $0.leading.trailing.equalTo(separatorLine)
            $0.height.equalTo(1)
        }
        memberLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(secondSeparatorLine.snp.bottom).offset(bound.height*0.0111)
        }
        userListTableView.snp.makeConstraints {
            $0.top.equalTo(memberLabel.snp.bottom).offset(bound.height*0.0111)
            $0.leading.trailing.equalTo(secondSeparatorLine)
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
    }
    override func configureVC() {
        
    }
    
    // MARK: - Reactor
    override func bindState(reactor: ChattingReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        let userDS = RxTableViewSectionedReloadDataSource<UserListSection>{_, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: UserListCell.reusableID, for: ip) as? UserListCell else { return .init() }
            cell.model = item
            return cell
        }
        
        let drawerDS = RxCollectionViewSectionedReloadDataSource<DrawerSection>{_, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: DrawerCell.reusableID, for: ip) as? DrawerCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.users)
            .do(onNext: { [weak self] in
                if !$0.isEmpty{
                    self?.userListTableView.invalidateIntrinsicContentSize()
                }
            })
            .map { [UserListSection.init(header: "", items: $0)] }
            .bind(to: userListTableView.rx.items(dataSource: userDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.drawers)
            .map { [DrawerSection.init(header: "", items: $0)] }
            .bind(to: drawerCollectionView.rx.items(dataSource: drawerDS))
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension ChattingSettingSideVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (((bound.width*0.6859)-50) / 5)-8, height: (((bound.width*0.6859)-50) / 5)-8)
    }
}
