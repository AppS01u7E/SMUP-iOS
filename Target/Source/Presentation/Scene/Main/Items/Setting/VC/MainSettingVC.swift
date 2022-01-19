//
//  SettingVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit

final class MainSettingVC: baseVC<MainSettingReactor>{
    // MARK: - Properties
    private let profileView = SettingProfileView()
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(profileView)
    }
    override func setLayout() {
        profileView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(bound.height*0.3415)
        }
    }
    override func configureVC() {
        profileView.setUser(user: .init(username: "test", profileImageUrl: "https://avatars.githubusercontent.com/u/74440939?s=48&v=4", school: "대충어디학교"))
    }
}
