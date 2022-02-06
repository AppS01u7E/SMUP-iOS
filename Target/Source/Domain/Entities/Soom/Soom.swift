//
//  Soom.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources
import Foundation

enum GroupType: String, Codable {
    case counsil = "COUNSIL"
    case clubMajor = "CLUB_MAJOR"
    case clubCa = "CLUB_CA"
    case clubEtc = "CLUB_ETC"
    case team = "TEAM"
    case `class` = "CLASS"
}

struct Soom: ModelType, Identifiable{
    let id: UUID
    let name: String
    let owner: UUID
    let description: String
    let type: GroupType
}

extension Soom: IdentifiableType{
    var identity: String{
        return UUID().uuidString
    }
}
