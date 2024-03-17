//
//  ObservableTypeExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import RxSwift

public extension ObservableType {
  static func fromAsync(_ asyncFunc: (@escaping @Sendable () async throws -> Element)) -> Observable<Element> {
    Observable.create { observer in
      let task = Task {
        do {
          let value = try await asyncFunc()
          observer.onNext(value)
          observer.onCompleted()
        } catch {
          observer.onError(error)
        }
      }
      return Disposables.create { task.cancel() }
    }
  }
  
  func mapToVoid() -> Observable<Void> {
    return self.map { _ in }
  }
  
  func mapToOptional() -> Observable<Element?> {
    return self.map { $0 as Element? }
  }
}
