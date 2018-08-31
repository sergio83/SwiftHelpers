//
//  DateExtension.swift
//  dropoff
//
//  Created by Sergio Cirasa on 22/2/18.
//  Copyright © 2018 Sergio Cirasa. All rights reserved.
//

import Foundation

extension Date{
    
    public func dateAtBeginningOfDay() -> Date {
        let calendar = NSCalendar.current
        let date = calendar.startOfDay(for: self)
        return date
    }
    
    public func dateAtBeginningOfDay(timezone:TimeZone?) -> Date {
        var calendar = NSCalendar.current
        if let timezone = timezone{
            calendar.timeZone = timezone
        }
        let date = calendar.startOfDay(for: self)
        return date
    }
    
    func timeIntervalAtBeginningOfDay() -> TimeInterval {
        let date = dateAtBeginningOfDay()
        return date.timeIntervalSince1970
    }
  
    public func dateAtEndOfDay() -> Date {
        let calendar = NSCalendar.current
        var components5 = DateComponents()
        components5.day = 1
        components5.second = -1
        let date = calendar.date(byAdding: components5, to: dateAtBeginningOfDay())
        return date!
    }
    
    static public func tomorrow(timezone:TimeZone? = nil) -> Date {
        var calendar = NSCalendar.current
        if let timezone = timezone{
            calendar.timeZone = timezone
        }
        var components5 = DateComponents()
        components5.day = 1
        let date = calendar.date(byAdding: components5, to: Date().dateAtBeginningOfDay(timezone:timezone))
        return date!
    }
    
    func timeIntervalAtEndOfDay() -> TimeInterval {
        let date = dateAtEndOfDay()
        return date.timeIntervalSince1970
    }
    
    func minutes() -> Int{
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let totalMinutes = hour * 60 + minute
        return totalMinutes
    }
    
    func minutes(timezone:TimeZone?) -> Int{
        var calendar = Calendar.current
        if let timezone = timezone{
            calendar.timeZone = timezone
        }
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let totalMinutes = hour * 60 + minute
        return totalMinutes
    }

}
