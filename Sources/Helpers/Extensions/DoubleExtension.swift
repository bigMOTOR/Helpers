//
//  DoubleExtension.swift
//  
//
//  Created by Mykola Fiantsev on 26.05.2023.
//

import Foundation

public extension Double {
  /// Rounds the double to decimal places value
  func roundToDecimals(_ decimals: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Double {
    let divisor = pow(10.0, Double(decimals))
    return (self * divisor).rounded(rule) / divisor
  }
}
