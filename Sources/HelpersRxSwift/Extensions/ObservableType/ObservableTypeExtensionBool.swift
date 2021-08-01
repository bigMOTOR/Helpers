//
//  ObservableTypeExtensionBool.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType where Element == Bool {
  
  func filterFalse() -> Observable<Void> {
    return self.filter { $0 == true }.mapToVoid()
  }
  
  func filterTrue() -> Observable<Void> {
    return self.filter { $0 == false }.mapToVoid()
  }
  
  func invert() -> Observable<Element> {
    return self.map { !$0 }
  }
  
  func asDelayedActivity(_ delay: DispatchTimeInterval = .milliseconds(200)) -> Observable<Bool> {
    return Observable
      .of(
        self.filter { $0 }
          .flatMapLatest {
            Observable.just($0)
              .delaySubscription(delay, scheduler: MainScheduler.instance)
              .take(until: self.filter { !$0 })
          },
        self.filter { !$0 }
      )
      .merge()
  }
  
  func asDelayedActivityDriver(_ delay: DispatchTimeInterval = .microseconds(400)) -> Driver<Bool> {
    return self
      .asDelayedActivity(delay)
      .asDriver(onErrorJustReturn: false)
  }
  
}
