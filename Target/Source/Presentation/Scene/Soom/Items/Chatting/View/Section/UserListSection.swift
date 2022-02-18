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
    var items: [User]
}

extension UserListSection{
    typealias Item = User
    init(original: UserListSection, items: [User]) {
        self = original
        self.items = items
    }
}
