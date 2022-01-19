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
        case setUsers([dummyUser])
        case setDrawer([String])
        case setId(String)
    }
    struct State{
        var content: String = ""
        var messages: [Message] = []
        var users: [dummyUser] = []
        var drawers: [String] = []
        var id: String = ""
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension ChattingReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case let .`init`(id):
            return .concat([
                .just(.setMessages(getChatDummy(id: id))),
                .just(.setId(id))
            ])
        case let .updateContent(con):
            return .just(.setContent(con))
        case .sideButtonDidTap:
            steps.accept(SMUPStep.chattingSettingIsRequired(reactor: self))
            return .concat([
                .just(.setUsers(getMemberDummy(id: currentState.id))),
                .just(.setDrawer(getDrawerDummy(id: currentState.id)))
            ])
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
        case let .setUsers(users):
            newState.users = users
        case let .setDrawer(urls):
            newState.drawers = urls
        case let .setId(id):
            newState.id = id
        }
        return newState
    }
}


// MARK: - Method
private extension ChattingReactor{
    func getChatDummy(id: String) -> [Message]{
        return [
            .init(content: "fdzz", sender: Sender(senderId: "unique", displayName: "baegteun")),
            .init(content: "fdzzzz")
        ]
    }
    func getMemberDummy(id: String) -> [dummyUser]{
        return [
            .init(username: "baegteun", profileImageUrl: "https://avatars.githubusercontent.com/u/74440939?s=64&v=4", school: "대덕소프트웨어마이스터고드학교"),
            .init(username: "sunghun", profileImageUrl: "https://avatars.githubusercontent.com/u/81547954?v=4", school: "광주소프트웨어마이스터고등학교")
        ]
    }
    func getDrawerDummy(id: String) -> [String]{
        return [
            "https://avatars.githubusercontent.com/u/81547954?v=4",
            "https://avatars.githubusercontent.com/u/81547954?v=4"
        ]
    }
}
