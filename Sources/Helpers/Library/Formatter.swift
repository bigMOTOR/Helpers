//
//  Formatter.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation

public struct Formatter {
  public typealias FormatterTransform = (NumberFormatter)->NumberFormatter
  fileprivate let _transform: FormatterTransform
  
  // Use with the APIs that require NSNumberFormatter
  public var nsNumberFormatter: NumberFormatter {
    return _transform(NumberFormatter())
  }
  
  public init(_ transform: @escaping FormatterTransform) {
    self._transform = transform
  }
    
  public func get<N: NSNumberConvertable>(_ number: N) -> String {
    // swiftlint:disable force_unwrapping
    return _transform(NumberFormatter()).string(from: number.asNSNumber)!
    // swiftlint:enable force_unwrapping
  }
  
  public func map(_ transform: @escaping FormatterTransform) -> Formatter {
    return Formatter { transform(self._transform($0)) }
  }
  
  // MARK: Formatting
  public func fractionDigits(min minDigits: Int = 0, max maxDigits: Int = 0) -> Formatter {
    return map { formatter in
      formatter.maximumFractionDigits = maxDigits
      formatter.minimumFractionDigits = minDigits
      return formatter
    }
  }
  
  public func currencySymbol(_ symbol: String) -> Formatter {
    return map { formatter in
      formatter.currencySymbol = symbol
      return formatter
    }
  }
}

public extension Formatter {
  init() {
    self = Formatter { formatter in
      formatter.roundingMode = .halfUp
      formatter.numberStyle = .decimal
      formatter.locale = Locale.current
      formatter.negativePrefix = "-"
      return formatter
    }
  }
  
  static func currency(in locale: Locale = Locale.current, fallbackCurrencySymbol: String = .naString) -> Formatter {
    return Formatter._currency(with: locale.currencySymbol ?? fallbackCurrencySymbol, in: locale)
  }
  
  static func currency(with symbol: String, in locale: Locale = Locale.current) -> Formatter {
    return Formatter._currency(with: symbol, in: locale)
  }
  
  private static func _currency(with symbol: String, in locale: Locale) -> Formatter {
    return Formatter { formatter in
      formatter.numberStyle = .currency
      formatter.locale = locale
      formatter.currencySymbol = symbol
      formatter.minimumFractionDigits = 2
      formatter.maximumFractionDigits = 2
      formatter.negativePrefix = "-"
      return formatter
    }
  }
}

public protocol NSNumberConvertable {
  var asNSNumber: NSNumber { get }
}

extension Double: NSNumberConvertable {
  public var asNSNumber: NSNumber {
    return NSNumber(value: self)
  }
}

extension Int: NSNumberConvertable {
  public var asNSNumber: NSNumber {
    return NSNumber(value: self)
  }
}

extension NSNumber: NSNumberConvertable {
  public var asNSNumber: NSNumber {
    return self
  }
}
