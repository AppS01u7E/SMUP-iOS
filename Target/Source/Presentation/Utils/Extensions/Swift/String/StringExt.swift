//
//  StringExt.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/22.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import SwiftDate

extension String{
    func toHour() -> Date{
        return self.toDate("HH:mm")?.date ?? .init()
    }
}
