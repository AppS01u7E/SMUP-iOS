//
//  TimeMapFlow.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxFlow
import RxRelay

struct TimeMapStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return SMUPStep.timeMapIsRequired
    }
}

final class TimeMapFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    @Inject private var vc: TimeMapVC
    @Inject var stepper: TimeMapStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
        
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSMUPStep else { return .none }
        switch step{
        case .timeMapIsRequired:
            return coordinateToTimeMap()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension TimeMapFlow{
    func coordinateToTimeMap() -> FlowContributors{
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor))
    }
}