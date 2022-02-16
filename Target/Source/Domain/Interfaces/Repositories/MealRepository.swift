//
//  MealRepository.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxSwift
import Foundation

protocol MealRepository {
    func getMeal(at date: Date) -> Single<Meal>
    func getTodayMeal() -> Single<Meal>
}
