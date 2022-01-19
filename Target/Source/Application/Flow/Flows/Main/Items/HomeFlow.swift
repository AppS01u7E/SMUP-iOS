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
        case let .timeMapIsRequired(date):
            return navigateToTimeMap(selectedDate: date)
        case let .timeMapDetailIsRequired(schedules, cur):
            return presentToTimeMapDetail(schedules: schedules, current: cur)
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
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor))
    }
    func navigateToTimeMap(selectedDate: Date) -> FlowContributors{
        let vc = TimeMapVC(selectedDate: selectedDate)
        (self.rootVC.tabBarController as? MainTabbarVC)?.setFlaotyButtonHidden(true)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor))
    }
    func presentToTimeMapDetail(schedules: [TimeMap], current: Int) -> FlowContributors{
        let vc = TimeMapDetailVC(schedules: schedules, current: current)
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.rootVC.present(vc, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor))
    }
    func dismissVC() -> FlowContributors{
        self.rootVC.visibleViewController?.dismiss(animated: true, completion: nil)
        return .none
    }
}
