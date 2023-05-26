//
//  CalendarExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation

extension Calendar {
  static var gregorianUTC: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    // swiftlint:disable force_unwrapping
    calendar.timeZone = TimeZone(identifier: "UTC")!
    // swiftlint:enable force_unwrapping
    calendar.locale = Locale.current
    return calendar
  }()
}
