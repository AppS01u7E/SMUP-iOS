//
//  SoomCategorySection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct SoomCategorySection: AnimatableSectionModelType{
    let header: Stirng
    var items: [SoomCategory]
}

extension SoomCategorySection{
    typealias Item = SoomCategory
    init(original: SoomCategorySection, items: [SoomCategory]) {
        self = original
        self.items = items
    }
}
