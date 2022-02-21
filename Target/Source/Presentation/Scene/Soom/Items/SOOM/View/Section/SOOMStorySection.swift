//
//  SOOMStorySection.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/02/20.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct SOOMStorySection : AnimatableSectionModelType {
    let header : String
    var items: [SoomHeaderModel]
}

extension SOOMStorySection {
    typealias Item = SoomHeaderModel
    init(original : SOOMStorySection, items: [SoomHeaderModel]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return UUID().uuidString
    }
    
}
