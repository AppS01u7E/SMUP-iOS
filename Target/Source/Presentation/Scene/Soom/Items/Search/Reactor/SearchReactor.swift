//
//  ChattingReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/14.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxCocoa

final class SearchReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case viewWillAppear
    }
    enum Mutation{
        case setSoom([Soom])
    }
    struct State{
        var sooms: [Soom] = []
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension SearchReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewWillAppear:
            return .just(.setSoom(getSoomMock()))
        default:
            return .empty()
        }
    }
}

// MARK: - Reduce
extension SearchReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSoom(soom):
            newState.sooms = soom
        }
        return newState
    }
}


// MARK: - Method
private extension SearchReactor{
    func getSoomMock() -> [Soom]{
        return [
            .init(name: "Info - Appsolute", description: "안녕하세요! \n저희 동아리는 이거 만들구요, \n저희는 이런 사람들이 있습니다."),
            .init(name: "피크닉", description: "도망치세요! \n여기는 읍읍"),
            .init(name: "대충 숨", description: "대충 설명이라는 뜻"),
            .init(name: "대충 숨이라는 뜻", description: "대충 설명")
        ]
    }
}
