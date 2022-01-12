//
//  SignInReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/12.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class SignInReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case appleSignInButtonDidTap
    }
    enum Mutation{
    }
    struct State{
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension SignInReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .appleSignInButtonDidTap:
//            steps.accept(SMUPStep.appleSignInIsRequired) // 아직은 퍼블리싱만
            steps.accept(SMUPStep.mainTabbarIsRequired)
            return .empty()
        }
    }
}

// MARK: - Reduce
extension SignInReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        }
        return newState
    }
}


// MARK: - Method
private extension SignInReactor{
    
}
