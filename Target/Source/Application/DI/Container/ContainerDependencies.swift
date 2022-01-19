//
//  ContainerDependencies.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/12.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import RxFlow

extension Container{
    func registerDependencies() {
        registerVC()
        registerReactor()
        registerStepper()
        registerFlow()
    }
    
    // MARK: - VC
    private func registerVC() {
        autoregister(SignInVC.self, initializer: SignInVC.init)
        autoregister(HomeVC.self, initializer: HomeVC.init)
        autoregister(TimeMapVC.self, initializer: TimeMapVC.init)
        autoregister(ChatListVC.self, initializer: ChatListVC.init)
        autoregister(TimeMapDetailVC.self, initializer: TimeMapDetailVC.init)
        autoregister(SOOMVC.self, initializer: SOOMVC.init)
        autoregister(MainSettingVC.self, initializer: MainSettingVC.init)
        autoregister(SearchVC.self, initializer: SearchVC.init)
        autoregister(MySchoolVC.self, initializer: MySchoolVC.init)
    }
    
    // MARK: - Reactor
    private func registerReactor() {
        autoregister(SignInReactor.self, initializer: SignInReactor.init)
        autoregister(HomeReactor.self, initializer: HomeReactor.init)
        autoregister(TimeMapReactor.self, initializer: TimeMapReactor.init)
        autoregister(TimeMapDetailReactor.self, initializer: TimeMapDetailReactor.init)
        autoregister(ChattingReactor.self, initializer: ChattingReactor.init)
        autoregister(ChatListReactor.self, initializer: ChatListReactor.init)
        autoregister(SOOMReactor.self, initializer: SOOMReactor.init)
        autoregister(MainSettingReactor.self, initializer: MainSettingReactor.init)
        autoregister(SearchReactor.self, initializer: SearchReactor.init)
        autoregister(MySchoolReactor.self, initializer: MySchoolReactor.init)
    }
    
    // MARK: - Stepper
    private func registerStepper() {
        autoregister(SignInStepper.self, initializer: SignInStepper.init)
        autoregister(HomeStepper.self, initializer: HomeStepper.init)
        autoregister(ChattingStepper.self, initializer: ChattingStepper.init)
        autoregister(SOOMStepper.self, initializer: SOOMStepper.init)
        autoregister(SettingStepper.self, initializer: SettingStepper.init)
        autoregister(SearchStepper.self, initializer: SearchStepper.init)
        autoregister(MySchoolStepper.self, initializer: MySchoolStepper.init)
    }
    
    // MARK: - Flow
    private func registerFlow() {
        autoregister(SignInFlow.self, initializer: SignInFlow.init)
        autoregister(HomeFlow.self, initializer: HomeFlow.init)
        autoregister(ChattingFlow.self, initializer: ChattingFlow.init)
        autoregister(SOOMFlow.self, initializer: SOOMFlow.init)
        autoregister(SettingFlow.self, initializer: SettingFlow.init)
        autoregister(SearchFlow.self, initializer: SearchFlow.init)
        autoregister(MySchoolFlow.self, initializer: MySchoolFlow.init)
    }
}
