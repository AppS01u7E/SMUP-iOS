//
//  ChattingSettingSideVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import SideMenu
import UIKit

final class ChattingSettingSideVC: baseVC<ChattingReactor>{
    // MARK: - Properties
    private let titleLabel = UILabel()
    
    private let separatorLine = UIView().then {
        $0.backgroundColor = UIColor(red: 0.486, green: 0.486, blue: 0.486, alpha: 1)
    }
    
    private let userList = UITableView().then {
        $0.register(UserListCell.self, forCellReuseIdentifier: UserListCell.reusableID)
        $0.separatorStyle = .none
        $0.rowHeight = 38
    }
    
    private let secondSeparatorLine = UIView().then {
        $0.backgroundColor = UIColor(red: 0.486, green: 0.486, blue: 0.486, alpha: 1)
    }
    
    private let drawerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(titleLabel, separatorLine, userList, secondSeparatorLine)
    }
    override func setLayout() {
        
    }
    override func configureVC() {
        self.view.backgroundColor = .systemBlue
    }
}
