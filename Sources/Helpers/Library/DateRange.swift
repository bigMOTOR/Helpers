//
//  DateRange.swift
//  
//
//  Created by Mykola Fiantsev on 25.05.2023.
//

import Foundation

public struct DateRange: Equatable {
  public let from: Date
  public let to: Date
  
  public init(from: Date, to: Date) {
    self.from = from
    self.to = to
  }
}
