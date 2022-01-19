//
//  Channel.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/19.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import RxDataSources

struct Channel{
    let name: String
    let users: [dummyUser]
    let resources: [UIImage]
}

struct dummyUser: ModelType{
    let username: String
    let profileImageUrl: String
    
}

extension dummyUser: IdentifiableType{
    var identity: String{
        return UUID().uuidString
    }
}
