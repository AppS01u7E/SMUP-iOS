//
//  TimeMap.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

struct TimeMap {
    let perio: Int
    let content: String
    enum CodingKeys: String, CodingKey{
        case perio = "PERIO"
        case content = "ITRT_CNTNT"
    }
}
