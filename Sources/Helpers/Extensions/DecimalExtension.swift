//
//  DecimalExtension.swift
//  
//
//  Created by Mykola Fiantsev on 26.05.2023.
//

import Foundation

public extension Decimal {
  var doubleValue: Double {
    return NSDecimalNumber(decimal: self).doubleValue
  }
}
