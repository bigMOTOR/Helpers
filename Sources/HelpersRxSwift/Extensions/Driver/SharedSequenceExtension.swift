//
//  SharedSequenceExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

public extension SharedSequence {
  func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
    return self.map { _ in }
  }
}
