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
    }
    
    // MARK: - Root
    var root: Presentable{
        return self.rootVC
    }
    @Inject private var homeFlow: HomeFlow
    @Inject private var SearchFlow: SearchFlow
    @Inject private var chatFlow: ChattingFlow
    @Inject private var soomFlow: SOOMFlow
    @Inject private var settingFlow: SettingFlow
    
    private let rootVC: SoomTabbarVC = .init()
    
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
                homeFlow, SearchFlow, chatFlow, soomFlow, settingFlow
            ], when: .created
        ) { [unowned self] (roots) in
            
            let SearchFloaty = JJActionItem()
            SearchFloaty.buttonImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let soomFloaty = JJActionItem()
            soomFloaty.buttonImage = UIImage(systemName: "rectangle.on.rectangle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let homeFloaty = JJActionItem()
            homeFloaty.buttonImage = UIImage(systemName: "house")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let settingFloaty = JJActionItem()
            settingFloaty.buttonImage = UIImage(systemName: "person")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let chatFloaty = JJActionItem()
            chatFloaty.buttonImage = UIImage(systemName: "message")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let items = [SearchFloaty, chatFloaty, settingFloaty, soomFloaty, homeFloaty]
            
            self.rootVC.setViewControllers(viewControllers: roots, floaties: items, animated: false)
        }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: homeFlow.stepper),
            .contribute(withNextPresentable: SearchFlow, withNextStepper: SearchFlow.stepper),
            .contribute(withNextPresentable: chatFlow, withNextStepper: chatFlow.stepper),
            .contribute(withNextPresentable: soomFlow, withNextStepper: soomFlow.stepper),
            .contribute(withNextPresentable: settingFlow, withNextStepper: settingFlow.stepper)
        ])
    }
}
