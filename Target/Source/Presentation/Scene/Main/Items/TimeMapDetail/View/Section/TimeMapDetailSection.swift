//
//  TimeMapDetailSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct TimeMapDetailSection{
    let header: String
    var items: [Item]
}

extension TimeMapDetailSection: AnimatableSectionModelType{
    typealias Item = TimeMap
    
    init(original: TimeMapDetailSection, items: [TimeMap]) {
        self = original
        self.items = items
    }
    
    var identity: String{
        return UUID().uuidString
    }
}
