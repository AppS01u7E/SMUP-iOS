//
//  Alarm.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources
import Foundation

struct Alarm: Codable, Equatable{
    let id: String
    let content: String
    let date: Date
}

extension Alarm: IdentifiableType{
    var identity: String{
        return UUID().uuidString
    }
}
