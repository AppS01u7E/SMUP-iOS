//
//  AlarmSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct AlarmSection: AnimatableSectionModelType{
    let header: String
    var items: [Alarm]
}

extension AlarmSection{
    typealias Item = Alarm
    
    init(original: AlarmSection, items: [Alarm]) {
        self = original
        self.items = items
    }
    var identity: String{
        return UUID().uuidString
    }
}
