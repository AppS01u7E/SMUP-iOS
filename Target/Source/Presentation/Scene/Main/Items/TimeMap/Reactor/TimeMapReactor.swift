//
//  TimeMapReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class TimeMapReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case viewDidAppear
    }
    enum Mutation{
        case setSchedule([TimeMap])
    }
    struct State{
        var schedules: [TimeMap] = []
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension TimeMapReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidAppear:
            print("ASDF")
            return .just(.setSchedule([
                .init(perio: 1, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(perio: 2, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(perio: 3, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(perio: 4, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(perio: 5, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(perio: 6, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(perio: 7, name: "토익사관학교", content: ["이건 미친짓이야..!", "도망쳐.."], reference: "김성훈님이 1학년 2학 Chat에 공지하셨어요!"),
            ]))
        }
    }
}

// MARK: - Reduce
extension TimeMapReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSchedule(tm):
            newState.schedules = tm
        }
        return newState
    }
}


// MARK: - Method
private extension TimeMapReactor{
        
}
