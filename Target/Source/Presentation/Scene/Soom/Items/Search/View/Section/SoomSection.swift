//
//  SoomSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct SoomSection: AnimatableSectionModelType{
    let header: String
    var items: [Soom]
}

extension SoomSection{
    typealias Item = Soom
    
    init(original: SoomSection, items: [Soom]) {
        self = original
        self.items = items
    }
    
    var identity: String{
        return UUID().uuidString
    }
}
