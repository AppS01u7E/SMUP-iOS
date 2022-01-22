//
//  ChatListSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct ChatListSection: AnimatableSectionModelType{
    let header: String
    var items: [ChatList]
}

extension ChatListSection{
    typealias Item = ChatList
    init(original: ChatListSection, items: [ChatList]) {
        self = original
        self.items = items
    }
    var identity: String{
        return UUID().uuidString
    }
}
