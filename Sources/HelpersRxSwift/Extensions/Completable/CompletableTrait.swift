//
//  CompletableTrait.swift
//  
//
//  Created by Nikolay Fiantsev on 01.10.2021.
//

import Foundation
import RxSwift

public extension PrimitiveSequenceType where Element == Never, Trait == CompletableTrait {
  func asVoidResultObservable() -> Observable<Result<Void, Error>> {
    return self
      .andThen(.just(.success(())))
      .catch { error in
        .just(.failure(error))
      }
  }
}
