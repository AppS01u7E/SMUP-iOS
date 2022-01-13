//
//  MainTabbarFlow.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/13.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxFlow

final class MainTabbarFlow: Flow{
    // MARK: - TabIndex
    enum TabIndex: Int{
        case home = 0
    }
    
    // MARK: - Root
    var root: Presentable{
        return self.rootVC
    }
    
    private let rootVC: MainTabbarVC = .init()
    
    // MARK: - deinit
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSMUPStep else { return .none }
        
        switch step{
            
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MainTabbarFlow{
    
}
