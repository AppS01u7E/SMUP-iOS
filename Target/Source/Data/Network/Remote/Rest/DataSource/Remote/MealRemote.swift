//
//  MealRemote.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxSwift
import Foundation

final class MealRemote: BaseRemote<MealAPI> {
    static let shared = MealRemote()
    
    func getMeal(date: Date) -> Single<Meal> {
        return request(.getMeal(date))
            .map(Meal.self)
    }
    func getTodayMeal() -> Single<Meal> {
        return request(.getTodayMeal)
            .map(Meal.self)
            .catchAndReturn(.init(breakfast: ["a"], lunch: ["a"], dinner: ["a"]))
    }
}
