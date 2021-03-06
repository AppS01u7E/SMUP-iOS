//
//  HomeFlow.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxFlow
import RxRelay
import Foundation
import UIKit

struct HomeStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return SMUPStep.homeIsRequired
    }
}

final class HomeFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    @Inject private var vc: HomeVC
    @Inject var stepper: HomeStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSMUPStep else { return .none }
        switch step{
        case .homeIsRequired:
            return coordinateToHome()
        case .alarmIsRequired:
            return navigateToAlarm()
        case .dismiss:
            return dismissVC()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension HomeFlow{
    func coordinateToHome() -> FlowContributors{
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func navigateToAlarm() -> FlowContributors{
        @Inject var vc: AlarmVC
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor ?? .init()))
    }
    func dismissVC() -> FlowContributors{
        self.rootVC.visibleViewController?.dismiss(animated: true, completion: nil)
        return .none
    }
}
