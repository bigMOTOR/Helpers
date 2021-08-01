//
//  SingleTraitExtensionSequence.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import RxSwift

public extension PrimitiveSequence where Element: Sequence, Trait == SingleTrait {
  func mapArray<T>(_ transform: @escaping (Element.Element)->T) -> PrimitiveSequence<SingleTrait, [T]> {
    return self.map { $0.map(transform) }
  }
}
