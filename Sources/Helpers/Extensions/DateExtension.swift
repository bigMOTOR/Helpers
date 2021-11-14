//
//  DateExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation

// MARK: - Unix Milliseconds
public extension Date {
  var unixMillisecondsSince1970: Int {
    return Int((timeIntervalSince1970 * 1000.0).rounded())
  }
  
  init(fromUnixMilliseconds timestamp: Int) {
    self = Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
  }
}

public extension Date {
  
  // MARK: - Date components
  var year: Int {
    return Calendar.gregorianUTC.component(.year, from: self)
  }
  
  var month: Int {
    return Calendar.gregorianUTC.component(.month, from: self)
  }
  
  var day: Int {
    return Calendar.gregorianUTC.component(.day, from: self)
  }
  
  func daysFrom(date: Date) -> Int {
    let calendar = Calendar.gregorianUTC
    let components = calendar.dateComponents([.day], from: date, to: self)
    return components.day ?? 0
  }
  
  // MARK: - Beginning of component
  var beginningOfYear: Date {
    let currentDateComponents = Calendar.gregorianUTC.dateComponents([.year] , from: self)
    return Calendar.gregorianUTC.date(from: currentDateComponents)!
  }
  
  var beginningOfMonth: Date {
    let currentDateComponents = Calendar.gregorianUTC.dateComponents([.year, .month], from: self)
    return Calendar.gregorianUTC.date(from: currentDateComponents)!
  }
  
  var beginningOfWeek: Date {
    var currentDateComponents = Calendar.gregorianUTC.dateComponents([.year, .month, .day, .weekday], from: self)
    currentDateComponents.day = currentDateComponents.day! - (currentDateComponents.weekday! - 1)
    return Calendar.gregorianUTC.date(from: currentDateComponents)!
  }
  
  var beginningOfDay: Date {
    return Calendar.gregorianUTC.startOfDay(for: self)
  }
  
  // MARK: - End of component
  var endOfDay: Date {
    return beginningOfDay.dateByAddingDays(1).addingTimeInterval(-1)
  }
  
  // MARK: - Adding components
  func dateByAddingDays(_ daysToAdd: Int) -> Date {
    return Calendar.gregorianUTC.date(byAdding: .day, value: daysToAdd, to: self)!
  }
  
  // MARK: - Comparison methods
  func isInRange(from: Date, to: Date) -> Bool {
    return self >= from && self <= to
  }
  
  func isCalendarMonthEqual(to date: Date) -> Bool {
    return year == date.year && month == date.month
  }
  
  func isCalendarDayEqual(to date: Date) -> Bool {
    return year == date.year && month == date.month && day == date.day
  }
}
