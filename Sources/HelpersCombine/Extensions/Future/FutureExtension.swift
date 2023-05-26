//
//  FutureExtension.swift
//  
//
//  Created by Mykola Fiantsev on 26.05.2023.
//

import Foundation
import Combine

public extension Future where Failure == Error {
  convenience init(asyncFunc: @escaping () async throws -> Output) {
    self.init { promise in
      Task {
        do {
          let result = try await asyncFunc()
          promise(.success(result))
        } catch {
          promise(.failure(error))
        }
      }
    }
  }
}

extension Future where Failure == Never {
  convenience init(asyncFunc: @escaping () async -> Output) {
    self.init { promise in
      Task {
        let result = await asyncFunc()
        promise(.success(result))
      }
    }
  }
}
