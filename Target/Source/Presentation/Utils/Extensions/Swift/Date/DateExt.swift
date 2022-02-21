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
        return self.resetDate().isInRange(date: perio.convertStartTime().toDate("HH:mm")!.date, and: perio.convertEndTime().toDate("HH:mm")!.date)
    }
    
    func getPeriod() -> Int {
        let reseted = self.resetDate()
        if reseted.isInRange(
            date: "00010101T08:40".toDate(style: .custom("yyyyMMdd'T'HH:mm"))?.date ?? .init(),
            and: "00010101T09:30".toDate(style: .custom("yyyyMMdd'T'HH:mm"))?.date ?? .init()) {
            return 1
        }
        return 0
    }
    
    func resetDate() -> Date{
        return Date(year: 1, month: 1, day: 1, hour: self.hour, minute: self.minute, region: .UTC)
    }
    
    func convertKorea() -> Date{
        return self + 9.hours
    }
    
    func getCurrentTimeinterval() -> Double {
        let converted = Date().convertKorea()
        let forData = Date(year: converted.year, month: converted.month, day: converted.day, hour: 0,
                           minute: 0, second: 0, nanosecond: 0)
        return Date().convertKorea().timeIntervalSince(forData)
    }
    
    func convertSchedule() -> String{
        var str = "\(self.toString(.custom("a hh시 mm분")))\n"
        str.append("곧 n교시 수업이 시작됩니다")
        return str
    }
    
    func convertCustomString() -> String{
        if self.isToday{
            return self.convertKorea().toString(.custom("a hh:mm분"))
        }
        else if self.isYesterday{
            return "어제"
        }
        else{
            return self.convertKorea().toString(.custom("yyyy.MM.dd"))
        }
    }
}
