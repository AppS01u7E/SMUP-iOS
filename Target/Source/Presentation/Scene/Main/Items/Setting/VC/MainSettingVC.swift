//
//  SettingVC.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout

final class MainSettingVC: baseVC<MainSettingReactor>{
    // MARK: - Properties
    private let rootConainter = UIView()
    private let profileView = SettingProfileView()
    private let accountSettingButton = SettingIconButton(image: .init(systemName: "person.crop.circle") ?? .init(), title: "계정 설정")
    private let alarmButton = SettingIconButton(image: .init(systemName: "bell.circle") ?? .init(), title: "알림 설정")
    private let schoolButton = SettingIconButton(image: .init(systemName: "graduationcap") ?? .init(), title: "학교 설정")
    private let logoutButton = SettingIconButton(image: .init(systemName: "rectangle.portrait.and.arrow.right") ?? .init(), title: "로그아웃")
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(rootConainter)
    }
    override func setLayoutSubViews() {
        rootConainter.pin.all()
        
        rootConainter.flex.layout()
    }
    override func setLayout() {
        rootConainter.flex.define { flex in
            flex.addItem(profileView).width(100%).height(34%)
            flex.addItem().height(66%).alignItems(.center).define { flex in
                flex.addItem().direction(.row).width(100%).marginTop(16%).justifyContent(.spaceEvenly).define { flex in
                    flex.addItem(accountSettingButton).size(90)
                    flex.addItem(alarmButton).size(90)
                }
                flex.addItem().direction(.row).width(100%).marginTop(8.2%).justifyContent(.spaceEvenly).define { flex in
                    flex.addItem(schoolButton).size(90)
                    flex.addItem(logoutButton).size(90)
                }
            }
            
        }
    }
    override func configureVC() {
        view.backgroundColor = SMUPAsset.smupGray1.color
        profileView.setUser(user: .init(username: "test", profileImageUrl: "https://avatars.githubusercontent.com/u/74440939?s=48&v=4", school: "대충어디학교"))
    }
}
