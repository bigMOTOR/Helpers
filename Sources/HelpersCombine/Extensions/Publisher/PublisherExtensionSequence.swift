// swiftlint:disable:this file_name
//
//  PublisherExtensionSequence.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import Combine

public extension Publisher where Output: Sequence {
  func mapArray<T>(_ transform: @escaping (Output.Element)->T) -> Publishers.Map<Self, [T]> {
    return self.map { $0.map(transform) }
  }
}
