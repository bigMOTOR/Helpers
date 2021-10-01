//
//  Single.swift
//  
//
//  Created by Nikolay Fiantsev on 01.10.2021.
//

import Foundation
import RxSwift

public extension Single {
  static func fromAsync(_ block: @escaping (@escaping (Element)->Void)->Void) -> Single<Element> {
    Single.create { observer in
      block { result in
        observer(.success(result))
      }
      return Disposables.create()
    }
  }
}
