//
//  SoomCategory.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Differentiator

struct SoomCategory: Equatable{
    let major: Major
    let color: UIColor
}
extension SoomCategory: IdentifiableType{
    var identity: String{
        return UUID().uuidString
    }
}

enum Major: String{
    case web = "Web"
    case app = "App"
    case backEnd = "BackEnd"
    case game = "Game"
}
