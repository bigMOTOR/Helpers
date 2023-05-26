//
//  AppStoreReview.swift
//  
//
//  Created by Nikolay Fiantsev on 02.08.2021.
//

import Foundation
import StoreKit

#if os(iOS) || os(macOS)
public protocol AppStoreReview {
  func shouldAsk(for count: Int) -> Bool
}

public extension AppStoreReview {
  func incrementCount() {
    UserDefaults.standard.storedCount += 1
  }
  
  /// This will not be shown everytime. Apple has some internal logic on how to show this.
  func tryToAsk() {
    switch shouldAsk(for: UserDefaults.standard.storedCount) {
    case true:
      SKStoreReviewController.requestReview()
    case false:
      break
    }
  }
}
#endif

private extension UserDefaults {
  var storedCount: Int {
    get { UserDefaults.standard.integer(forKey: #function) }
    set { UserDefaults.standard.set(newValue, forKey: #function) }
  }
}
