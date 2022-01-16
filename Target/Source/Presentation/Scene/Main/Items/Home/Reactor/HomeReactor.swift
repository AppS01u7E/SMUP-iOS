//
//  HomeReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa
import SwiftDate

final class HomeReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case plusDay
        case minusDay
    }
    enum Mutation{
        case setDate(Date)
    }
    struct State{
        var selectedDate = Date()
        var meal = Meal(breakfast: [], lunch: [], dinner: [])
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension HomeReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .plusDay:
            return .just(.setDate(currentState.selectedDate + 1.days))
        case .minusDay:
            return .just(.setDate(currentState.selectedDate - 1.days))
        }
    }
}

// MARK: - Reduce
extension HomeReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setDate(date):
            newState.selectedDate = date
        }
        return newState
    }
}
    

// MARK: - Method
private extension HomeReactor{
    
}
