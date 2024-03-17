//
//  Single.swift
//  
//
//  Created by Nikolay Fiantsev on 01.10.2021.
//

import Foundation
import RxSwift

public extension Single {
  static func fromAsync(_ asyncFunc: (@escaping @Sendable () async throws -> Element)) -> Single<Element> {
    Single.create { observer in
      let task = Task {
        do {
          let value = try await asyncFunc()
          observer(.success(value))
        } catch {
          observer(.failure(error))
        }
      }
      return Disposables.create { task.cancel() }
    }
  }
}
