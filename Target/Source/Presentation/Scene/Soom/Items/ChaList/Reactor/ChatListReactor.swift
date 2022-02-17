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
        case chattingDidTap(String)
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
        case let .chattingDidTap(id):
            steps.accept(SMUPStep.chattingIsRequired(id: id))
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
            .init(id: "asdf", isDone: true, name: "김성훈", profile: "https://avatars.githubusercontent.com/u/74440939?v=4", unreadCount: 0),
            .init(id: "fdsa", isDone: false, name: "ㅁㄴㅇㄹ", profile: "https://avatars.githubusercontent.com/u/74440939?v=4", unreadCount: 2),
            .init(id: "ssss", isDone: true, name: "baegte", profile: "https://avatars.githubusercontent.com/u/74440939?v=4", unreadCount: 0 )
        ]
    }
}
