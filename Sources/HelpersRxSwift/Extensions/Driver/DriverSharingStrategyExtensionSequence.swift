// swiftlint:disable:this file_name
//
//  DriverSharingStrategyExtensionSequence.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

public extension SharedSequence where SharingStrategy == DriverSharingStrategy, Element: Sequence {
  func mapArray<T>(_ transform: @escaping (Element.Element)->T) -> SharedSequence<DriverSharingStrategy, [T]> {
    return self.map { $0.map(transform) }
  }
}
