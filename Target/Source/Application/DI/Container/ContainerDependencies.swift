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
        autoregister(ChattingVC.self, initializer: ChattingVC.init)
        autoregister(SOOMVC.self, initializer: SOOMVC.init)
        autoregister(SettingVC.self, initializer: SettingVC.init)
    }
    
    // MARK: - Reactor
    private func registerReactor() {
        autoregister(SignInReactor.self, initializer: SignInReactor.init)
        autoregister(HomeReactor.self, initializer: HomeReactor.init)
        autoregister(TimeMapReactor.self, initializer: TimeMapReactor.init)
        autoregister(ChattingReactor.self, initializer: ChattingReactor.init)
        autoregister(SOOMReactor.self, initializer: SOOMReactor.init)
        autoregister(SettingReactor.self, initializer: SettingReactor.init)
    }
    
    // MARK: - Stepper
    private func registerStepper() {
        autoregister(SignInStepper.self, initializer: SignInStepper.init)
        autoregister(HomeStepper.self, initializer: HomeStepper.init)
        autoregister(TimeMapStepper.self, initializer: TimeMapStepper.init)
        autoregister(ChattingStepper.self, initializer: ChattingStepper.init)
        autoregister(SOOMStepper.self, initializer: SOOMStepper.init)
        autoregister(SettingStepper.self, initializer: SettingStepper.init)
    }
    
    // MARK: - Flow
    private func registerFlow() {
        autoregister(SignInFlow.self, initializer: SignInFlow.init)
        autoregister(HomeFlow.self, initializer: HomeFlow.init)
        autoregister(TimeMapFlow.self, initializer: TimeMapFlow.init)
        autoregister(ChattingFlow.self, initializer: ChattingFlow.init)
        autoregister(SOOMFlow.self, initializer: SOOMFlow.init)
        autoregister(SettingFlow.self, initializer: SettingFlow.init)
    }
}
