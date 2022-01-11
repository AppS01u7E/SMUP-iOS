//
//  ContainerDependencies.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/12.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

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
    }
    
    // MARK: - Reactor
    private func registerReactor() {
        autoregister(SignInReactor.self, initializer: SignInReactor.init)
    }
    
    // MARK: - Stepper
    private func registerStepper() {
        autoregister(SignInStepper.self, initializer: SignInStepper.init)
    }
    
    // MARK: - Flow
    private func registerFlow() {
        autoregister(SignInFlow.self, initializer: SignInFlow.init)
    }
}
