//
//  DateExt.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/18.
//  Copyright © 2022 baegteun. All rights reserved.
//

import Foundation
import SwiftDate

extension Date{
    func isInPerio(perio: Int) -> Bool{
        print( perio.convertStartTime().toDate("HH:mm")!.date)
        print( perio.convertEndTime().toDate("HH:mm")!.date)
        print(self.resetDate())
        print(perio.convertStartTime().toDate("HH:mm")!.date <= self.resetDate() &&
              perio.convertEndTime().toDate("HH:mm")!.date >= self.resetDate())
        return self.resetDate().isInRange(date: perio.convertStartTime().toDate("HH:mm")!.date, and: perio.convertEndTime().toDate("HH:mm")!.date)
        
    }
    
    func resetDate() -> Date{
        return Date(year: 2000, month: 1, day: 1, hour: self.hour, minute: self.minute) + 9.hours
    }
}
