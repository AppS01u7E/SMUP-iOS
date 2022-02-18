//
//  ChatListReactor.swift
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

final class ChatListReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case viewDidAppear
        case updateQuery(String)
        case chattingDidTap(ChatRoom)
    }
    enum Mutation{
        case setChatList([ChatRoom])
        case setQuery(String)
    }
    struct State{
        var chatLists: [ChatRoom] = []
        var query = ""
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension ChatListReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidAppear:
            return .just(.setChatList(getDummyChatList()))
        case let .updateQuery(q):
            return .just(.setQuery(q))
        case let .chattingDidTap(room):
            steps.accept(SMUPStep.chattingIsRequired(id: room.id, isDone: room.isDone))
            return .empty()
        default:
            return .empty()
        }
    }
}

// MARK: - Reduce
extension ChatListReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setChatList(list):
            newState.chatLists = list
        case let .setQuery(q):
            newState.query = q
        }
        return newState
    }
}


// MARK: - Method
private extension ChatListReactor{
    func getDummyChatList() -> [ChatRoom] {
        return [
            
        ]
    }
}
