//
//  ChattingFlow.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxFlow
import SideMenu
import RxRelay
import UIKit

struct ChattingStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return SMUPStep.chatListIsRequired
    }
}

final class ChattingFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    @Inject private var vc: ChatListVC
    @Inject var stepper: ChattingStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSMUPStep else { return .none }
        switch step{
        case .chatListIsRequired:
            return coordinateToChatList()
        case let .chattingIsRequired(ID):
            return navigateToChatting(ID: ID)
        case let .chattingSettingIsRequired(reactor):
            print("ASF")
            return presentToChattingSetting(reactor: reactor)
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension ChattingFlow{
    func coordinateToChatList() -> FlowContributors{
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor))
    }
    func navigateToChatting(ID: String) -> FlowContributors{
        let vc = ChattingVC(ID: ID)
        (self.rootVC.tabBarController as? MainTabbarVC)?.setFlaotyButtonHidden(true)
        (self.rootVC.tabBarController as? SoomTabbarVC)?.setFlaotyButtonHidden(true)
        self.rootVC.isNavigationBarHidden = false
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor))
    }
    func presentToChattingSetting(reactor: ChattingReactor) -> FlowContributors{
        let vc = SideMenuNavigationController(rootViewController: ChattingSettingSideVC(reactor: reactor))
        vc.statusBarEndAlpha = 0
        vc.dismissOnPresent = true
        vc.dismissOnPush = true
        vc.enableTapToDismissGesture = true
        vc.enableSwipeToDismissGesture = true
        vc.menuWidth = UIScreen.main.bounds.width*0.6859
        vc.presentationStyle = .menuSlideIn
        SideMenuManager.default.rightMenuNavigationController = vc
        SideMenuManager.default.rightMenuNavigationController?.setNavigationBarHidden(true, animated: false)
        let presentingVC = SideMenuManager.default.rightMenuNavigationController ?? .init(nibName: nil, bundle: nil)
        self.rootVC.present(presentingVC, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: presentingVC, withNextStepper: reactor))
    }
}
