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
    
    func resetDate() -> Date{
        return Date(year: 1, month: 1, day: 1, hour: self.hour, minute: self.minute, region: .UTC)
    }
    
    func convertKorea() -> Date{
        return self + 9.hours
    }
    
    func convertSchedule() -> String{
        var str = "\(self.convertKorea().toString(.custom("a hh시 mm분")))\n"
        if self.resetDate().isInRange(date: 1.convertStartTime().toHour() - 10.minutes, and: 1.convertStartTime().toHour()){
            str.append("곧 1교시 수업이 시작됩니다")
        }
        else if self.resetDate().isInRange(date: 1.convertStartTime().toHour(), and: 1.convertEndTime().toHour()){
            str.append("지금은 1교시 수업중")
        }
        else if self.resetDate().isInRange(date: 2.convertStartTime().toHour() - 10.minutes, and: 2.convertStartTime().toHour()){
            str.append("곧 2교시 수업이 시작됩니다")
        }
        else if self.resetDate().isInRange(date: 2.convertStartTime().toHour(), and: 2.convertEndTime().toHour()){
            str.append("지금은 2교시 수업중")
        }
        else if self.resetDate().isInRange(date: 3.convertStartTime().toHour() - 10.minutes, and: 3.convertStartTime().toHour()){
            str.append("곧 2교시 수업이 시작됩니다")
        }
        else if self.resetDate().isInRange(date: 3.convertStartTime().toHour(), and: 3.convertEndTime().toHour()){
            str.append("지금은 3교시 수업중")
        }
        else if self.resetDate().isInRange(date: 4.convertStartTime().toHour() - 10.minutes, and: 4.convertStartTime().toHour()){
            str.append("곧 4교시 수업이 시작됩니다")
        }
        else if self.resetDate().isInRange(date: 4.convertStartTime().toHour(), and: 4.convertEndTime().toHour()){
            str.append("지금은 4교시 수업중")
        }
        else if self.resetDate().isInRange(date: 5.convertStartTime().toHour(), and: 5.convertEndTime().toHour()){
            str.append("지금은 5교시 수업중")
        }
        else{
            str.append("지금은 n교시 수업중")
        }
        return str
    }
    
    func getCurrentTimeinterval() -> Double {
        let forData = Date(year: self.year, month: self.month, day: self.day, hour: 0,
                           minute: 0, second: 0, nanosecond: 0)
        return Date().convertKorea().timeIntervalSince(forData)
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
