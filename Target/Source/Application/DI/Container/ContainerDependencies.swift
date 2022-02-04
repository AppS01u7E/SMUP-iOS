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
        register(SignInVC.self) { r in
            return SignInVC(reactor: r.resolve(SignInReactor.self))
        }
        register(HomeVC.self) { r in
            return HomeVC(reactor: r.resolve(HomeReactor.self))
        }
        register(ChatListVC.self) { r in
            return ChatListVC(reactor: r.resolve(ChatListReactor.self))
        }
        register(SOOMVC.self) { r in
            return SOOMVC(reactor: r.resolve(SOOMReactor.self))
        }
        register(MainSettingVC.self) { r in
            return MainSettingVC(reactor: r.resolve(MainSettingReactor.self))
        }
        register(SearchVC.self) { r in
            return SearchVC(reactor: r.resolve(SearchReactor.self))
        }
        register(MySchoolVC.self) { r in
            return MySchoolVC(reactor: r.resolve(MySchoolReactor.self))
        }
        register(AlarmVC.self) { r in
            return AlarmVC(reactor: r.resolve(AlarmReactor.self))
        }
    }
    
    // MARK: - Reactor
    private func registerReactor() {
        autoregister(SignInReactor.self, initializer: SignInReactor.init)
        autoregister(HomeReactor.self, initializer: HomeReactor.init)
        autoregister(ChattingReactor.self, initializer: ChattingReactor.init)
        autoregister(ChatListReactor.self, initializer: ChatListReactor.init)
        autoregister(AlarmReactor.self, initializer: AlarmReactor.init)
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
