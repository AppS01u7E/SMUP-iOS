//
//  ChatListSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct ChatListSection: SectionModelType{
    let header: String
    var items: [ChatRoom]
}

extension ChatListSection{
    typealias Item = ChatRoom
    init(original: ChatListSection, items: [ChatRoom]) {
        self = original
        self.items = items
    }
    var identity: String{
        return UUID().uuidString
    }
}
