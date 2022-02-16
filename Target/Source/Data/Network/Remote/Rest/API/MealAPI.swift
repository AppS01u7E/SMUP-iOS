//
//  MealAPI.swift
//  SMUP
//
//  Created by 최형우 on 2022/02/16.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Moya
import Foundation
import SwiftDate

enum MealAPI {
    case getMeal(Date)
    case getTodayMeal
}

extension MealAPI: SMUPAPI {
    var domain: SMUPDomain {
        return .meal
    }
    var urlPath: String {
        switch self {
        case .getMeal:
            return "/meal"
        case .getTodayMeal:
            return "/meal/today"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        switch self {
        case let .getMeal(date):
            return .requestParameters(parameters: [
                "date": date.toString(.custom("yyyyMMdd"))
            ], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }
    var errorMapper: [Int : SMUPError]?{
        return [
            401: .unauthorization,
            403: .forbidden,
            404: .notFound
        ]
    }
}
