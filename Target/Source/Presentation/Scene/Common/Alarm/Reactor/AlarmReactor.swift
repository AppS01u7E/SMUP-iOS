//
//  AlarmReactor.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import SwiftDate
import RxCocoa

final class AlarmReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case viewDidAppear
        case deleteButtonDidTap([Int])
        case deleteOneAlarm(String)
    }
    enum Mutation{
        case setAlarm([Alarm])
        case deleteAlarms([Int])
        case deleteOneAlarm(String)
    }
    struct State{
        var alarms: [Alarm] = []
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension AlarmReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidAppear:
            return .just(.setAlarm(getAlarmMock()))
        case let .deleteButtonDidTap(arr):
            return .just(.deleteAlarms(arr))
        case let .deleteOneAlarm(id):
            return .just(.deleteOneAlarm(id))
        }
    }
}

// MARK: - Reduce
extension AlarmReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setAlarm(alarm):
            newState.alarms = alarm
        case let .deleteAlarms(arr):
            arr.forEach{ item in
                newState.alarms.remove(at: item)
            }
        case let .deleteOneAlarm(id):
            newState.alarms.removeAll(where: { $0.id == id })
        }
        return newState
    }
}


// MARK: - Method
private extension AlarmReactor{
    func getAlarmMock() -> [Alarm] {
        return [
            .init(id: "1234", content: "가입을 환영합니다!", date: Date() - 3.days),
            .init(id: "e231", content: "이것은 더미데이터입니다!.", date: Date())
        ]
    }
}
