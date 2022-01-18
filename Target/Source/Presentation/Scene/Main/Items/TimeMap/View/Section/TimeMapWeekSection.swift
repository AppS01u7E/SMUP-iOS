//
//  TimeMapWeekSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources
import SwiftDate

struct TimeMapWeekSection: AnimatableSectionModelType{
    let header: String
    var items: [Item]
}
extension TimeMapWeekSection{
    typealias Item = WeekDay
    
    init(original: TimeMapWeekSection, items: [WeekDay]) {
        self = original
        self.items = items
    }
    
    var identity: String{
        return UUID().uuidString
    }
}


