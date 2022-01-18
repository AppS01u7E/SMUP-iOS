//
//  ChatList.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct ChatList: ModelType{
    let id: String
    let profileImageUrl: String
    let name: String
    let recentDate: Date
    let recentMessage: String
    let alarmCount: Int
}

extension ChatList: IdentifiableType{
    var identity: String{
        return UUID().uuidString
    }
}
