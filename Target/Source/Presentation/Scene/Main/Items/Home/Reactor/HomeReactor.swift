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
    
    // MARK: - Reactor
    enum Action{
        case viewDidLoad
        case afterDayButtonDidTap
        case beforeDayButtonDidTap
        case scheduleButtonDidTap
    }
    enum Mutation{
        case setDate(Date)
        case setMeal(Meal)
    }
    struct State{
        var selectedDate = Date()
        var meal = Meal(breakfast: [], lunch: [], dinner: [])
    }
    
    var initialState: State = State()
    
}

// MARK: - Mutate
extension HomeReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .viewDidLoad:
            // TODO: 대충 급식 가져오는 API 불러오는 단계 라이프사이클이라는 뜻
            return .just(.setMeal(.init(breakfast: ["아침","아침ㅁ"],
                                        lunch: ["점심", "점심ㅁ"],
                                        dinner: ["저녁", "저녁ㅁ"])))
        case .afterDayButtonDidTap:
            return .just(.setDate(currentState.selectedDate + 1.days))
        case .beforeDayButtonDidTap:
            return .just(.setDate(currentState.selectedDate - 1.days))
        case .scheduleButtonDidTap:
            steps.accept(SMUPStep.timeMapIsRequired(selectedDate: currentState.selectedDate))
            return .empty()
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
        }
        return newState
    }
}
    

// MARK: - Method
private extension HomeReactor{
    
}
