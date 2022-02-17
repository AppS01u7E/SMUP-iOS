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
        case let .chattingIsRequired(id):
            return navigateToChatting(withID: id)
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension ChattingFlow{
    func coordinateToChatList() -> FlowContributors{
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToChatting(withID id: String) -> FlowContributors {
        let reactor = ChattingReactor(id: id)
        let vc = ChattingVC()
        (self.rootVC.tabBarController as? SoomTabbarVC)?.setFlaotyButtonHidden(true)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}
