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
        case setChatList([ChatList])
        case setQuery(String)
    }
    struct State{
        var chatLists: [ChatList] = []
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
            steps.accept(SMUPStep.chattingIsRequired(withID: id))
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
    func getDummyChatList() -> [ChatList] {
        return [
            .init(id: "asdf", profileImageUrl: "https://yt3.ggpht.com/ytc/AKedOLRtjfB6gUvfT114pomkfO_-caO0cQ7Gy7bq9iMa=s88-c-k-c0x00ffffff-no-rj", name: "asdf", recentDate: Date(), recentMessage: "fdzz", alarmCount: 1),
            .init(id: "FDSA", profileImageUrl: "https://yt3.ggpht.com/ytc/AKedOLRtjfB6gUvfT114pomkfO_-caO0cQ7Gy7bq9iMa=s88-c-k-c0x00ffffff-no-rj", name: "김성훈", recentDate: Date(), recentMessage: "일하셈", alarmCount: 0),
            .init(id: "ASFW", profileImageUrl: "https://yt3.ggpht.com/ytc/AKedOLQMv0jnwUZ6pwWFbRuJtu26dj9VyKz8JY2wbzi-3aI=s88-c-k-c0x00ffffff-no-rj", name: "ㅁㄴㅇㄹ", recentDate: (Date() - 1.days), recentMessage: "ㅇ?", alarmCount: 2)
        ]
    }
}
