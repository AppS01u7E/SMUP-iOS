//
//  MySchoolReactor.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class MySchoolReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        
    }
    enum Mutation{
    }
    struct State{
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension MySchoolReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        default:
            return .empty()
        }
    }
}

// MARK: - Reduce
extension MySchoolReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        }
        return newState
    }
}


// MARK: - Method
private extension MySchoolReactor{
    
}
