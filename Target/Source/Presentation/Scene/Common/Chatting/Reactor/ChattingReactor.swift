//
//  ChattingReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class ChattingReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case `init`(String)
    }
    enum Mutation{
    }
    struct State{
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension ChattingReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .`init`(id):
            return .empty()
        default:
            return .empty()
        }
    }
}

// MARK: - Reduce
extension ChattingReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        }
        return newState
    }
}


// MARK: - Method
private extension ChattingReactor{
    func getDummy(id: String){
        
    }
}
