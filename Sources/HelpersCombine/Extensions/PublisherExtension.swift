//
//  PublisherExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation
import Combine

public extension Publisher {
  func mapToVoid() -> Publishers.Map<Self, Void> {
    return self.map { _ in }
  }
  
  func mapToOptional() -> Publishers.Map<Self, Self.Output?> {
    return self.map { $0 as Self.Output? }
  }
  
  func flatMapLatest<T: Publisher>(_ transform: @escaping (Self.Output)->T) -> Publishers.SwitchToLatest<T, Publishers.Map<Self, T>> where T.Failure == Self.Failure {
    return self.map(transform)
      .switchToLatest()
  }
}
