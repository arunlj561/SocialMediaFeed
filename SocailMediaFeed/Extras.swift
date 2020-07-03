//
//  Extras.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

let pageLimit = 10

extension UITableViewCell{
    static var reuseIdentifier:String{
        return "\(self)"
    }
}

func getQueryParams(_ param:[String:Any?]) -> [URLQueryItem]?{
    return param.map { (key: String, value: Any?) -> URLQueryItem in
        if let value = value {
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
        return URLQueryItem(name: "", value: "")
    }
}

extension Int{
    func formatUsingAbbrevation () -> String {
        let numFormatter = NumberFormatter()

        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (100_000_000.0, 1_000_000_000.0, "B")]
                                           // you can add more !

        let startValue = Double (abs(self))
        let abbreviation:Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()

        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1

        return numFormatter.string(from: NSNumber (value:value))!
    }

}

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
