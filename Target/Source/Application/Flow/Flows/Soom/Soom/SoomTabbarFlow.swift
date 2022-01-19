//
//  MainTabbarFlow.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/13.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxFlow
import JJFloatingActionButton

final class SoomTabbarFlow: Flow{
    // MARK: - TabIndex
    enum TabIndex: Int{
        case home = 0
        case search
        case chat
        case soom
        case setting
    }
    
    // MARK: - Root
    var root: Presentable{
        return self.rootVC
    }
    
    @Inject private var searchFlow: SearchFlow
    @Inject private var chatFlow: ChattingFlow
    @Inject private var soomFlow: SOOMFlow
    @Inject private var settingFlow: SettingFlow
    
    let rootVC: SoomTabbarVC = .init()
    
    // MARK: - deinit
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSMUPStep else { return .none }
        
        switch step{
        case .soomTabbarIsRequired:
            return coordinateToSoomTabbar()
        case .mainTabbarIsRequired:
            return .end(forwardToParentFlowWithStep: SMUPStep.mainTabbarIsRequired)
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension SoomTabbarFlow{
    func coordinateToSoomTabbar() -> FlowContributors{
        Flows.use(
            [
                soomFlow, chatFlow, searchFlow, settingFlow
            ], when: .created
        ) { [unowned self] (roots) in
            
            let soomFloaty = JJActionItem()
            soomFloaty.buttonImage = UIImage(systemName: "rectangle.on.rectangle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let searchFloaty = JJActionItem()
            searchFloaty.buttonImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let chatFloaty = JJActionItem()
            chatFloaty.buttonImage = UIImage(systemName: "message")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let settingFloaty = JJActionItem()
            settingFloaty.buttonImage = UIImage(systemName: "person")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let homeFloaty = JJActionItem()
            homeFloaty.buttonImage = UIImage(systemName: "house")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let items = [soomFloaty, searchFloaty, chatFloaty, settingFloaty, homeFloaty]
            
            self.rootVC.setViewControllers(viewControllers: roots, floaties: items, animated: false)
        }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: searchFlow, withNextStepper: searchFlow.stepper),
            .contribute(withNextPresentable: chatFlow, withNextStepper: chatFlow.stepper),
            .contribute(withNextPresentable: soomFlow, withNextStepper: soomFlow.stepper),
            .contribute(withNextPresentable: settingFlow, withNextStepper: settingFlow.stepper)
        ])
    }
}
