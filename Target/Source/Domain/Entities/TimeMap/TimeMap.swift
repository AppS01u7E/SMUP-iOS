//
//  TimeMap.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources
import Foundation

struct TimeMap: ModelType{
    let date: Date
    let perio: Int
    let name: String
    let content: [String]
    let reference: String
}

extension TimeMap: IdentifiableType, Equatable{
    var identity: String{
        return UUID().uuidString
    }
}
