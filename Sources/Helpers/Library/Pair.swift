//
//  Pair.swift
//  
//
//  Created by Nikolay Fiantsev on 14.01.2022.
//

import Foundation

/// Hashable Pair
public struct Pair<T: Hashable, U: Hashable>: Hashable {
  public let first: T
  public let second: U
  
  public init(first: T, second: U) {
    self.first = first
    self.second = second
  }
}
