//
//  ObservableTypeExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import RxSwift

public extension ObservableType {
  func mapToVoid() -> Observable<Void> {
    return self.map { _ in }
  }
  
  func mapToOptional() -> Observable<Element?> {
    return self.map { $0 as Element? }
  }
}
