//
//  iOSVersions.swift
//  
//
//  Created by Nikolay Fiantsev on 08.11.2021.
//

import Foundation

public extension Bool {
  static var iOS15: Bool {
    if #available(iOS 15, *) {
      return true
    } else {
      return false
    }
  }
}
