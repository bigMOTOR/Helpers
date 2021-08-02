//
//  WrappedError.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import Foundation
import Combine

public struct WrappedError: Error {
  let base: Error
  
  public init(base: Error) {
    self.base = base
  }
}

extension WrappedError: Equatable {
  public static func == (lhs: WrappedError, rhs: WrappedError) -> Bool {
    return lhs.base.localizedDescription == rhs.base.localizedDescription
  }
}

public extension Publisher {
  func mapToWrappedError() -> Publishers.MapError<Self, WrappedError> {
    return self
      .mapError(WrappedError.init)
  }
  
  func mapToNSError() -> Publishers.MapError<Self, NSError> {
    return mapError { $0 as NSError }
  }
}
