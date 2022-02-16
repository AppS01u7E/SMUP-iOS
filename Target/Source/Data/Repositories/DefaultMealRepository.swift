//
//  DefaultMealRepository.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import RxSwift

final class DefaultMealRepository: MealRepository {
    let ds = MealRemote.shared
    func getMeal(at date: Date) -> Single<Meal> {
        return ds.getMeal(date: date)
    }
    func getTodayMeal() -> Single<Meal> {
        return ds.getTodayMeal()
    }
}
