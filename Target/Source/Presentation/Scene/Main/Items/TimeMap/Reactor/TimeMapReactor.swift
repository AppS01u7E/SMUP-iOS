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
import SwiftDate

final class TimeMapReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactor
    enum Action{
        case viewDidAppear
        case scheduleDetailIsRequired(Int)
    }
    enum Mutation{
        case setSchedule([Schedule])
    }
    struct State{
        var schedules: [Schedule] = []
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension TimeMapReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidAppear:
            return Observable<Mutation>.just(Mutation.setSchedule([
                .init(date: "2021년 12월 24일".toDate("yyyy년 MM월 dd일")?.date ?? Date(), perio: 1, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(date: "2021년 12월 25일".toDate("yyyy년 MM월 dd일")?.date ?? Date(), perio: 2, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(date: "2021년 12월 26일".toDate("yyyy년 MM월 dd일")?.date ?? Date(), perio: 3, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(date: "2021년 12월 27일".toDate("yyyy년 MM월 dd일")?.date ?? Date(), perio: 4, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(date: "2021년 12월 28일".toDate("yyyy년 MM월 dd일")?.date ?? Date(), perio: 5, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(date: "2021년 12월 29일".toDate("yyyy년 MM월 dd일")?.date ?? Date(), perio: 6, name: "토익사관학교", content: ["이건 미친짓이야..!"], reference: ""),
                .init(date: "2021년 12월 30일".toDate("yyyy년 MM월 dd일")?.date ?? Date(), perio: 7, name: "토익사관학교", content: ["이건 미친짓이야..!", "도망쳐.."], reference: "김성훈님이 1학년 2학 Chat에 공지하셨어요!"),
            ]))
        case let .scheduleDetailIsRequired(cur):
            steps.accept(SMUPStep.timeMapDetailIsRequired(schedules: currentState.schedules, current: cur))
            return .empty()
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
