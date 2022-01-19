//
//  TimeMapScheduleSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct TimeMapScheduleSection: AnimatableSectionModelType{
    let header: String
    var items: [TimeMap]
}

extension TimeMapScheduleSection{
    typealias Item = TimeMap
    init(original: TimeMapScheduleSection, items: [TimeMap]) {
        self = original
        self.items = items
    }
    
    var identity: String{
        return UUID().uuidString
    }
}
