//
//  AppFlow.swift
//
//
//  Created by baegteun on 2021/11/30.
//

import RxFlow
import RxRelay
import RxSwift

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    
    func readyToEmitSteps() {
        Observable.just(SMUPStep.signInIsRequired)
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}

final class AppFlow: Flow{
    
    // MARK: - Properties
    var root: Presentable{
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    
    // MARK: - Init
    
    init(
        with window: UIWindow
    ){
        self.rootWindow = window
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSMUPStep else { return .none }
        
        switch step{
        case .signInIsRequired:
            return coordinateToSignIn()
        case .mainTabbarIsRequired:
            return coordinateToMainTabbar()
        case .soomTabbarIsRequired:
            return coordinateToSoomTabbar()
        default:
            return .none
        }
    }
}

// MARK: - Method

private extension AppFlow{
    func coordinateToSignIn() -> FlowContributors {
        let flow = SignInFlow()
        
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: SMUPStep.signInIsRequired)))
    }
    func coordinateToMainTabbar() -> FlowContributors{
        let flow = MainTabbarFlow()
        
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: SMUPStep.mainTabbarIsRequired)))
    }
    
    func coordinateToSoomTabbar() -> FlowContributors{
        let flow = MainTabbarFlow()
        
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: SMUPStep.soomTabbarIsRequired)))
    }
}

