// swiftlint:disable:this file_name
//
//  PublisherExtensionBool.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import Combine

public extension Publisher where Output == Bool {
  func filterFalse() -> Publishers.Map<Publishers.Filter<Self>, Void> {
    return self
      .filter { $0 == true }
      .mapToVoid()
  }

  func filterTrue() -> Publishers.Map<Publishers.Filter<Self>, Void> {
    return self
      .filter { $0 == false }
      .mapToVoid()
  }

  func invert() -> Publishers.Map<Self, Bool> {
    return self.map(!)
  }
}
