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
        case soom
        case mySchool
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
            homeFlow, mySchoolFlow, settingFlow
            , when: .created
        ) { [unowned self] (root1: UINavigationController,
                            root2: UINavigationController,
                            root3: UINavigationController) in
            
            let homeImage = UIImage(systemName: "house")
            let soomImage = UIImage(systemName: "rectangle.on.rectangle")
            let schoolImage = UIImage(systemName: "graduationcap")
            let settingImage = UIImage(systemName: "person")
            
            let homeItem = UITabBarItem(title: nil, image: homeImage, tag: 0)
            let soomItem = UITabBarItem(title: nil, image: soomImage, tag: 1)
            let schoolItem = UITabBarItem(title: nil, image: schoolImage, tag: 2)
            let settingItem = UITabBarItem(title: nil, image: settingImage, tag: 3)
            
            let soom = UIViewController()
            root1.tabBarItem = homeItem
            soom.tabBarItem = soomItem
            root2.tabBarItem = schoolItem
            root3.tabBarItem = settingItem
            
            self.rootVC.setViewControllers([root1, soom, root2, root3], animated: true)
        }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: homeFlow.stepper),
            .contribute(withNextPresentable: mySchoolFlow, withNextStepper: mySchoolFlow.stepper),
            .contribute(withNextPresentable: settingFlow, withNextStepper: settingFlow.stepper),
        ])
    }
}
