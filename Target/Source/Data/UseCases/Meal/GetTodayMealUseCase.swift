//
//  GetTodayMealUseCase.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxSwift
import Foundation

final class GetTodayMealUseCase {
    @Inject private var repository: MealRepository
    
    func execute() -> Single<Meal> {
        return repository.getTodayMeal()
    }
}
