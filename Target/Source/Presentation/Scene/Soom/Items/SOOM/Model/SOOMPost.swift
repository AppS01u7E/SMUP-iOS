//
//  SOOMPost.swift
//  SMUP
//
//  Created by Sunghun Kim on 2022/02/20.
//  Copyright © 2022 baegteun. All rights reserved.
//

import RxDataSources
import Foundation
import Differentiator
import UIKit

struct SOOMPost : Equatable{
    
    let id : String
    let profileImageUrl : String
    let ownerImageUrl : String
    let owner : String
    let postDate : Date
    let title : String
    let postImageUrl : [String]
    let heartNumber : Int
    let commentNumber : Int
    let commenterProfileImageUrl : String
    let commenterName : String
    let commentDate : Date
    let comment : String
}

extension SOOMPost : IdentifiableType {
    var identity : String{
        return UUID().uuidString
    }
}
