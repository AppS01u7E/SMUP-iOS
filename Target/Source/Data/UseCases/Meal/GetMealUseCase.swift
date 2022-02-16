//
//  GetMealUseCase.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxSwift
import Foundation

final class GetMealUseCase {
    @Inject private var repository: MealRepository
    
    func execute(at date: Date) -> Single<Meal> {
        return repository.getMeal(at: date)
    }
}
