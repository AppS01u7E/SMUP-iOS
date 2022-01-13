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
        [SignInVC].forEach{ autoregister($0.self, initializer: $0.init) }
    }
    
    // MARK: - Reactor
    private func registerReactor() {
        [SignInReactor].forEach{ autoregister($0.self, initializer: $0.init) }
    }
    
    // MARK: - Stepper
    private func registerStepper() {
        [SignInStepper].forEach{ autoregister($0.self, initializer: $0.init) }
    }
    
    // MARK: - Flow
    private func registerFlow() {
        [SignInFlow].forEach{ autoregister($0.self, initializer: $0.init) }
    }
}
