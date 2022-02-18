//
//  HomeReactor.swift
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

final class HomeReactor: Reactor, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag = DisposeBag()
    
    @Inject private var getTodayMealUseCase: GetTodayMealUseCase
    
    // MARK: - Reactor
    enum Action{
        case viewDidAppear
        case alarmButtonDidTap
    }
    enum Mutation{
        case setDate(Date)
        case setMeal(Meal)
        case setSchedule(Schedule)
    }
    struct State{
        var selectedDate: Date
        var meal: Meal
        var scheduel: Schedule
    }
    
    var initialState: State
    
    init() {
        initialState = State(
            selectedDate: Date(),
            meal: .init(breakfast: [], lunch: [], dinner: []),
            scheduel: .init(date: Date(), perio: 0, name: "", content: [""], reference: "")
        )
    }
    
}

// MARK: - Mutate
extension HomeReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .alarmButtonDidTap:
            steps.accept(SMUPStep.alarmIsRequired)
            return .empty()
        case .viewDidAppear:
            return viewDidAppear()
        }
    }
}

// MARK: - Reduce
extension HomeReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setDate(date):
            newState.selectedDate = date
        case let .setMeal(meal):
            newState.meal = meal
        case let .setSchedule(schedule):
            newState.scheduel = schedule
        }
        return newState
    }
}
    

// MARK: - Method
private extension HomeReactor{
    func viewDidAppear() -> Observable<Mutation> {
        let schedule = Schedule(date: Date(), perio: 2, name: "김김김", content: ["집집집집집", "Asdf", "fda"], reference: "김김김님이 Soom에 공지하셨습니댜")
        return .concat([
            getTodayMealUseCase.execute().asObservable().map{ .setMeal($0) },
            .just(.setSchedule(schedule))
        ])
    }
}
