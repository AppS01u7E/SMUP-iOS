//
//  TimeMapDetailReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class TimeMapDetailReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case `init`([Schedule])
        case transparentDidTap
    }
    enum Mutation{
        case setSchedule([Schedule])
    }
    struct State{
        var schedulse: [Schedule] = []
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension TimeMapDetailReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .`init`(items):
            return .just(.setSchedule(items))
        case .transparentDidTap:
            steps.accept(SMUPStep.dismiss)
            return .empty()
        }
    }
}

// MARK: - Reduce
extension TimeMapDetailReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSchedule(items):
            newState.schedulse = items
        }
        return newState
    }
}


// MARK: - Method
private extension TimeMapDetailReactor{
    
}
