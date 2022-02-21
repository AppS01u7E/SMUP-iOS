//
//  MyModel.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Differentiator

struct SoomHeaderModel : Equatable{
    let color : UIColor
    let title: String
    let description: String
    let imageUrl: String
}

extension SoomHeaderModel : IdentifiableType {
    var identity: String {
        return UUID().uuidString
    }
}
