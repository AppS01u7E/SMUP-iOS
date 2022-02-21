//
//  SOOMPostSection.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/02/20.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct SOOMPostSection : AnimatableSectionModelType {
    let header : String
    var items : [SOOMPost]
}

extension SOOMPostSection {
    typealias Item = SOOMPost
    
    init(original: SOOMPostSection, items: [SOOMPost]){
        self = original
        self.items = items
    }
    
    var identity: String{
        return UUID().uuidString
    }
}
