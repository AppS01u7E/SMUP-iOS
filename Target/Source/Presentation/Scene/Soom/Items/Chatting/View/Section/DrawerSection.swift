//
//  DrawerSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct DrawerSection: SectionModelType{
    let header: String
    var items: [String]
}

extension DrawerSection{
    typealias Item = String
    init(original: DrawerSection, items: [String]) {
        self = original
        self.items = items
    }
}
