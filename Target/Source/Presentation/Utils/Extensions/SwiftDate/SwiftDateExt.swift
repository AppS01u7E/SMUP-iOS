//
//  SwiftDateExt.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import SwiftDate
import RxDataSources

extension WeekDay: IdentifiableType{
    public var identity: String{
        return UUID().uuidString
    }
}
