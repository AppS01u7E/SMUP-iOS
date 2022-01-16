//
//  SearchFlow.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/15.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxFlow
import RxRelay

struct SearchStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return SMUPStep.soomSearchingIsRequired
    }
}

final class SearchFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    @Inject private var vc: SearchVC
    @Inject var stepper: SearchStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSMUPStep else { return .none }
        switch step{
        case .soomSearchingIsRequired:
            return coordinateSearch()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension SearchFlow{
    func coordinateSearch() -> FlowContributors{
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor))
    }
}
