//
//  Soom.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct Soom: ModelType{
    let name: String
    let description: String
}

extension Soom: IdentifiableType{
    var identity: String{
        return UUID().uuidString
    }
}
