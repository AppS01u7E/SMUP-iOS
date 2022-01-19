//
//  UserListSection.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources

struct UserListSection: SectionModelType{
    let header: String
    var items: [dummyUser]
}

extension UserListSection{
    typealias Item = dummyUser
    init(original: UserListSection, items: [dummyUser]) {
        self = original
        self.items = items
    }
}
