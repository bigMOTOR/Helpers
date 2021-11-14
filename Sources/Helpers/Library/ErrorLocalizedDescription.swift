//
//  ErrorLocalizedDescription.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import Foundation

public protocol ErrorLocalizedDescription: LocalizedError, CustomStringConvertible {}

public extension ErrorLocalizedDescription {
  var errorDescription: String? {
    return description
  }
}
