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
        case updateContent(String)
        case sideButtonDidTap
    }
    enum Mutation{
        case setContent(String)
        case setMessages([Message])
    }
    struct State{
        var content: String = ""
        var messages: [Message] = []
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension ChattingReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .`init`(id):
            return .empty()
        case let .updateContent(con):
            return .just(.setContent(con))
        case .sideButtonDidTap:
            steps.accept(SMUPStep.chattingSettingIsRequired(reactor: self))
            return .empty()
        }
    }
}

// MARK: - Reduce
extension ChattingReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setContent(con):
            newState.content = con
        case let .setMessages(msgs):
            newState.messages = msgs
        }
        return newState
    }
}


// MARK: - Method
private extension ChattingReactor{
    func getDummy(id: String){
        
    }
}
