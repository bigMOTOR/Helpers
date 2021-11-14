//
//  ArrayExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation

public extension Array {
  subscript (safe index: Int) -> Element? {
    if index >= 0 && self.count > index {
      return self[index]
    }
    return nil
  }
}

public extension Array where Element: Hashable {
  func subtract(_ other: [Element]) -> [Element] {
    let thisSet = Set(self)
    let otherSet = Set(other)
    return Array(thisSet.subtracting(otherSet))
  }
}

public extension Collection {
  func distance(to index: Index) -> Int {
    distance(from: startIndex, to: index)
  }
}

