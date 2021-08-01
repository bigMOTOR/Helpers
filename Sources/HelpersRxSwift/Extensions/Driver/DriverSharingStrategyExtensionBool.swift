//
//  DriverSharingStrategyExtensionBool.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

public extension SharedSequence where SharingStrategy == DriverSharingStrategy, Element == Bool {
  
  func filterFalse() -> SharedSequence<DriverSharingStrategy, Void> {
    return self.filter { $0 == true }.mapToVoid()
  }
  
  func filterTrue() -> SharedSequence<DriverSharingStrategy, Void> {
    return self.filter { $0 == false }.mapToVoid()
  }
  
  func invert() -> SharedSequence<DriverSharingStrategy, Element> {
    return self.map { !$0 }
  }
}
