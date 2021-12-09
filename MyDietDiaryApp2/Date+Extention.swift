//
//  Date+Extention.swift
//  MyDietDiaryApp2
//
//  Created by 橋本純一 on 2021/12/09.
//

import Foundation

extension Date {
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        calendar.locale = Locale(identifier: "ja-JP")
        return calendar
    }
    
    func fixed(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, mitute: Int? = nil, second: Int? = nil) -> Date {
        var comp = DateComponents()
        comp.year = year ?? calendar.component(.year, from: self)
        comp.month = year ?? calendar.component(.month, from: self)
        comp.day = year ?? calendar.component(.day, from: self)
        comp.hour = year ?? calendar.component(.hour, from: self)
        comp.minute = year ?? calendar.component(.minute, from: self)
        comp.second = year ?? calendar.component(.second, from: self)
        return calendar.date(from: comp)!
    }
    
    var zeroclock: Date {
        return fixed(hour: 0, mitute: 0, second: 0)
    }
}
