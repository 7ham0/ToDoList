//
//  openFuncs.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 22.09.21.
//

import Foundation

class openFuncs {
    open func stringToDate(isoDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        return date
    }
    
    open func predicateForDayFromDate(date: NSDate) -> NSPredicate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var components = calendar!.components([.year, .month, .day, .hour, .minute, .second], from: date as Date)
        components.hour = 00
        components.minute = 00
        components.second = 00
        let startDate = calendar!.date(from: components)
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endDate = calendar!.date(from: components)

        return NSPredicate(format: "day >= %@ AND day =< %@", argumentArray: [startDate!, endDate!])
    }
}
