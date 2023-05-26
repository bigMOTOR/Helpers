//
//  DateExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation
import Helpers

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
  var yearUTC: Int {
    return year(on: .gregorianUTC)
  }

  var yearLocal: Int {
    return year(on: .current)
  }
  
  var monthUTC: Int {
    return month(on: .gregorianUTC)
  }

  var monthLocal: Int {
    return month(on: .current)
  }
  
  var dayUTC: Int {
    return day(on: .gregorianUTC)
  }

  var dayLocal: Int {
    return day(on: .current)
  }

  // MARK: - Beginning of component
  var beginningOfYearUTC: Date {
    return beginningOfYear(on: .gregorianUTC)
  }

  var beginningOfYearLocal: Date {
    return beginningOfYear(on: .current)
  }
  
  var beginningOfMonthUTC: Date {
    return beginningOfMonth(on: .gregorianUTC)
  }

  var beginningOfMonthLocal: Date {
    return beginningOfMonth(on: .current)
  }
  
  var beginningOfWeekUTC: Date {
    return beginningOfWeek(on: .gregorianUTC)
  }

  var beginningOfWeekLocal: Date {
    return beginningOfWeek(on: .current)
  }
  
  var beginningOfDayUTC: Date {
    return beginningOfDay(on: .gregorianUTC)
  }

  var beginningOfDayLocal: Date {
    return beginningOfDay(on: .current)
  }

  // MARK: - End of component
  var endOfYearUTC: Date {
    return endOfYear(on: .gregorianUTC)
  }

  var endOfYearLocal: Date {
    return endOfYear(on: .current)
  }
  
  var endOfMonthUTC: Date {
    return endOfMonth(on: .gregorianUTC)
  }

  var endOfMonthLocal: Date {
    return endOfMonth(on: .current)
  }
  
  var endOfDayUTC: Date {
    return endOfDay(on: .gregorianUTC)
  }

  var endOfDayLocal: Date {
    return endOfDay(on: .current)
  }

  // MARK: - Adding components
  func dateByAddingYears(_ yearsToAdd: Int, inUTC: Bool = true) -> Date {
    return dateByAddingYears(yearsToAdd, on: inUTC ? .gregorianUTC : .current)
  }
  
  func dateByAddingMonths(_ monthsToAdd: Int, inUTC: Bool = true) -> Date {
    return dateByAddingMonths(monthsToAdd, on: inUTC ? .gregorianUTC : .current)
  }

  func dateByAddingDays(_ daysToAdd: Int, inUTC: Bool = true) -> Date {
    return dateByAddingDays(daysToAdd, on: inUTC ? .gregorianUTC : .current)
  }

  // MARK: Distance from date in various components
  func yearsFrom(_ date: Date, inUTC: Bool = true) -> Int {
    return yearsFrom(date, on: inUTC ? .gregorianUTC : .current)
  }

  func monthsFrom(_ date: Date, inUTC: Bool = true) -> Int {
    return monthsFrom(date, on: inUTC ? .gregorianUTC : .current)
  }

  func daysFrom(_ date: Date, inUTC: Bool = true) -> Int {
    return daysFrom(date, on: inUTC ? .gregorianUTC : .current)
  }

  // MARK: - Comparison methods
  func isInRange(from: Date, to: Date) -> Bool {
    return self >= from && self <= to
  }

  func isCalendarMonthEqual(to date: Date, inUTC: Bool = true) -> Bool {
    return isCalendarMonthEqual(to: date, on: inUTC ? .gregorianUTC : .current)
  }

  func isCalendarDayEqual(to date: Date, inUTC: Bool = true) -> Bool {
    return isCalendarDayEqual(to: date, on: inUTC ? .gregorianUTC : .current)
  }

  // MARK: - Ranges
  func dayRange(inUTC: Bool) -> DateRange {
    return .dayRange(from: self, on: inUTC ? .gregorianUTC : .current)
  }
  
  func monthRange(inUTC: Bool) -> DateRange {
    return .monthRange(from: self, on: inUTC ? .gregorianUTC : .current)
  }
  
  func yearRange(inUTC: Bool) -> DateRange {
    return .yearRange(from: self, on: inUTC ? .gregorianUTC : .current)
  }
}

// MARK: - Strideable

extension Date: Strideable {
  public func distance(to other: Date) -> TimeInterval {
    return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
  }

  public func advanced(by n: TimeInterval) -> Date {
    return self + n
  }
}

// MARK: - Internal Core Stuff

internal extension Date {
  
  // MARK: - Date components
  func year(on calendar: Calendar) -> Int {
    return calendar.component(.year, from: self)
  }
  
  func month(on calendar: Calendar) -> Int {
    return calendar.component(.month, from: self)
  }

  func day(on calendar: Calendar) -> Int {
    return calendar.component(.day, from: self)
  }

  // MARK: - Beginning of component
  func beginningOfYear(on calendar: Calendar) -> Date {
    let currentDateComponents = calendar.dateComponents([.year], from: self)
    return calendar.date(from: currentDateComponents)!
  }
  
  func beginningOfMonth(on calendar: Calendar) -> Date {
    let currentDateComponents = calendar.dateComponents([.year, .month], from: self)
    return calendar.date(from: currentDateComponents)!
  }

  func beginningOfWeek(on calendar: Calendar) -> Date {
    var currentDateComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: self)
    currentDateComponents.day = currentDateComponents.day! - (currentDateComponents.weekday! - 1)
    return calendar.date(from: currentDateComponents)!
  }

  func beginningOfDay(on calendar: Calendar) -> Date {
    return calendar.startOfDay(for: self)
  }

  // MARK: - End of component
  func endOfYear(on calendar: Calendar) -> Date {
    return beginningOfYear(on: calendar).dateByAddingYears(1, on: calendar).addingTimeInterval(-1)
  }
  
  func endOfMonth(on calendar: Calendar) -> Date {
    return beginningOfMonth(on: calendar).dateByAddingMonths(1, on: calendar).addingTimeInterval(-1)
  }

  func endOfDay(on calendar: Calendar) -> Date {
    return beginningOfDay(on: calendar).dateByAddingDays(1, on: calendar).addingTimeInterval(-1)
  }

  // MARK: - Adding components
  func dateByAddingYears(_ yearsToAdd: Int, on calendar: Calendar) -> Date {
    return calendar.date(byAdding: .year, value: yearsToAdd, to: self)!
  }
  
  func dateByAddingMonths(_ monthsToAdd: Int, on calendar: Calendar) -> Date {
    return calendar.date(byAdding: .month, value: monthsToAdd, to: self)!
  }

  func dateByAddingDays(_ daysToAdd: Int, on calendar: Calendar) -> Date {
    return calendar.date(byAdding: .day, value: daysToAdd, to: self)!
  }
  
  // MARK: Distance from date in various components
  func yearsFrom(_ date: Date, on calendar: Calendar) -> Int {
    return calendar.dateComponents([.year], from: date, to: self).year!
  }

  func monthsFrom(_ date: Date, on calendar: Calendar) -> Int {
    return calendar.dateComponents([.month], from: date, to: self).month!
  }

  func daysFrom(_ date: Date, on calendar: Calendar) -> Int {
    return calendar.dateComponents([.day], from: date, to: self).day!
  }
  
  // MARK: - Comparison methods
  func isCalendarMonthEqual(to date: Date, on calendar: Calendar) -> Bool {
    return year(on: calendar) == date.year(on: calendar)
      && month(on: calendar) == date.month(on: calendar)
  }

  func isCalendarDayEqual(to date: Date, on calendar: Calendar) -> Bool {
    return year(on: calendar) == date.year(on: calendar)
      && month(on: calendar) == date.month(on: calendar)
      && day(on: calendar) == date.day(on: calendar)
  }
}

private extension DateRange {
  static func dayRange(from date: Date, on calendar: Calendar) -> DateRange {
    return .init(from: date.beginningOfDay(on: calendar), to: date.endOfDay(on: calendar))
  }

  static func monthRange(from date: Date, on calendar: Calendar) -> DateRange {
    return .init(from: date.beginningOfMonth(on: calendar), to: date.endOfMonth(on: calendar))
  }
  
  static func yearRange(from date: Date, on calendar: Calendar) -> DateRange {
    return .init(from: date.beginningOfYear(on: calendar), to: date.endOfYear(on: calendar))
  }
}
