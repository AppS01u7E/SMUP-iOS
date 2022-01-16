//
//  MainTabbarFlow.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/13.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxFlow
import JJFloatingActionButton
import RxRelay

final class MainTabbarFlow: Flow{
    // MARK: - TabIndex
    enum TabIndex: Int{
        case home = 0
        case mySchool = 1
        case chat
        case soom
        case setting
    }
    
    // MARK: - Root
    var root: Presentable{
        return self.rootVC
    }
    @Inject private var homeFlow: HomeFlow
    @Inject private var mySchoolFlow: MySchoolFlow
    @Inject private var chatFlow: ChattingFlow
    @Inject private var settingFlow: SettingFlow
    
    let rootVC: MainTabbarVC = .init()
    
    // MARK: - deinit
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSMUPStep else { return .none }
        
        switch step{
        case .mainTabbarIsRequired:
            return coordinateToMainTabbar()
        case .soomTabbarIsRequired:
            return .end(forwardToParentFlowWithStep: SMUPStep.soomTabbarIsRequired)
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MainTabbarFlow{
    func coordinateToMainTabbar() -> FlowContributors{
        Flows.use(
            [
                homeFlow, mySchoolFlow, chatFlow, settingFlow
            ], when: .created
        ) { [unowned self] (roots) in
            
            let homeFloaty = JJActionItem()
            homeFloaty.buttonImage = UIImage(systemName: "house")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let mySchoolFloaty = JJActionItem()
            mySchoolFloaty.buttonImage = UIImage(systemName: "graduationcap")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let chatFloaty = JJActionItem()
            chatFloaty.buttonImage = UIImage(systemName: "message")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let settingFloaty = JJActionItem()
            settingFloaty.buttonImage = UIImage(systemName: "person")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let soomFloaty = JJActionItem()
            soomFloaty.buttonImage = UIImage(systemName: "rectangle.on.rectangle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
            let items = [homeFloaty, mySchoolFloaty, chatFloaty, settingFloaty, soomFloaty]
            
            self.rootVC.setViewControllers(viewControllers: roots, floaties: items, animated: false)
            
        }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: homeFlow.stepper),
            .contribute(withNextPresentable: mySchoolFlow, withNextStepper: mySchoolFlow.stepper),
            .contribute(withNextPresentable: chatFlow, withNextStepper: chatFlow.stepper),
            .contribute(withNextPresentable: settingFlow, withNextStepper: settingFlow.stepper),
        ])
    }
}
