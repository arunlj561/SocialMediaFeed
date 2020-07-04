//
//  Date+Ext.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 04/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
extension Date{
    func timeAgoSinceNow(numericDates: Bool = true) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components: DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute,
                                                                              NSCalendar.Unit.hour,
                                                                              NSCalendar.Unit.day,
                                                                              NSCalendar.Unit.weekOfYear,
                                                                              NSCalendar.Unit.month,
                                                                              NSCalendar.Unit.year,
                                                                              NSCalendar.Unit.second],
                                                                             from: earliest,
                                                                             to: latest,
                                                                             options: NSCalendar.Options())

        guard
            let year = components.year,
            let month = components.month,
            let weekOfYear = components.weekOfYear,
            let day = components.day,
            let hour = components.hour,
            let minute = components.minute,
            let second = components.second
        else { return "A while ago"}

        if year >= 1 {
            return year >= 2 ? "\(year) years ago" : numericDates ? "1 year ago" : "Last year"
        } else if month >= 1 {
            return month >= 2 ? "\(month) months ago" : numericDates ? "1 month ago" : "Last month"
        } else if weekOfYear >= 1 {
            return weekOfYear >= 2 ? "\(weekOfYear) weeks ago" : numericDates ? "1 week ago" : "Last week"
        } else if day >= 1 {
            return day >= 2 ? "\(day) days ago" : numericDates ? "1 day ago" : "Yesterday"
        } else if hour >= 1 {
            return hour >= 2 ? "\(hour) hours ago" : numericDates ? "1 hour ago" : "An hour ago"
        } else if minute >= 1 {
            return minute >= 2 ? "\(minute) minutes ago" : numericDates ? "1 minute ago" : "A minute ago"
        } else {
            return second >= 3 ? "\(second) seconds ago" : "Just now"
        }
    }

}
