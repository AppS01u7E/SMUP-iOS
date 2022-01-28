//
//  IntExt.swift
//  SMUP
//
//  Created by 최형우 on 2022/01/17.
//  Copyright © 2022 baegteun. All rights reserved.
//

import SwiftDate

extension Int{
    func convertPerio() -> String{
        switch self{
        case 1: return "1교시"
        case 2: return "2교시"
        case 3: return "3교시"
        case 4: return "4교시"
        case 5: return "5교시"
        case 6: return "6교시"
        case 7: return "7교시"
        case 20: return "점심시간"
        case 21: return "저녁시간"
        default: return ""
        }
    }
    func convertStartTime() -> String{
        switch self{
        case 1: return "\(Date(year: 1, month: 1, day: 1, hour: 8, minute: 40).toString(.custom("HH:mm")))"
        case 2: return "\(Date(year: 1, month: 1, day: 1, hour: 9, minute: 40).toString(.custom("HH:mm")))"
        case 3: return "\(Date(year: 1, month: 1, day: 1, hour: 10, minute: 40).toString(.custom("HH:mm")))"
        case 4: return "\(Date(year: 1, month: 1, day: 1, hour: 11, minute: 40).toString(.custom("HH:mm")))"
        case 5: return "\(Date(year: 1, month: 1, day: 1, hour: 13, minute: 30).toString(.custom("HH:mm")))"
        case 6: return "\(Date(year: 1, month: 1, day: 1, hour: 14, minute: 30).toString(.custom("HH:mm")))"
        case 7: return "\(Date(year: 1, month: 1, day: 1, hour: 15, minute: 30).toString(.custom("HH:mm")))"
        default: return "\(Date(year: 1, month: 1, day: 1, hour: 12, minute: 40).toString(.custom("HH:mm")))"
        }
    }
    func convertEndTime() -> String{
        switch self{
        case 1: return "\(Date(year: 1, month: 1, day: 1, hour: 9, minute: 30).toString(.custom("HH:mm")))"
        case 2: return "\(Date(year: 1, month: 1, day: 1, hour: 10, minute: 30).toString(.custom("HH:mm")))"
        case 3: return "\(Date(year: 1, month: 1, day: 1, hour: 11, minute: 30).toString(.custom("HH:mm")))"
        case 4: return "\(Date(year: 1, month: 1, day: 1, hour: 12, minute: 30).toString(.custom("HH:mm")))"
        case 5: return "\(Date(year: 1, month: 1, day: 1, hour: 14, minute: 20).toString(.custom("HH:mm")))"
        case 6: return "\(Date(year: 1, month: 1, day: 1, hour: 15, minute: 20).toString(.custom("HH:mm")))"
        case 7: return "\(Date(year: 1, month: 1, day: 1, hour: 16, minute: 20).toString(.custom("HH:mm")))"
        default: return "\(Date(year: 1, month: 1, day: 1, hour: 13, minute: 30).toString(.custom("HH:mm")))"
        }
    }
}
