//
//  ChattingReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class ChattingReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        
    }
    enum Mutation {
        
    }
    struct State {
        var roomID: String
    }
    let initialState: State
    
    // MARK: - Init
    init(id: String) {
        initialState = State(
            roomID: id
        )
    }
    
}

// MARK: - Mutate
extension ChattingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
        return .empty()
    }
}

// MARK: - Reduce
extension ChattingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}

// MARK: - Method
private extension ChattingReactor {
    
}
