//
//  ObservableTypeExtensionSequence.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import RxSwift

public extension ObservableType where Element: Sequence {
  func mapArray<T>(_ transform: @escaping (Element.Element)->T) -> Observable<[T]> {
    return self.map { $0.map(transform) }
  }
}
