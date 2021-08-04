//
//  AppStoreReview.swift
//  
//
//  Created by Nikolay Fiantsev on 02.08.2021.
//

import Foundation
import StoreKit

public protocol AppStoreReview {
  func shouldAsk(for count: Int) -> Bool
}

public extension AppStoreReview {
  func incrementAppStoreReviewPointsCount() {
    UserDefaults.standard.storedCount = UserDefaults.standard.storedCount + 1
  }
  
  /// This will not be shown everytime. Apple has some internal logic on how to show this.
  func tryRequestReviewInCurrentScene() {
    switch shouldAsk(for: UserDefaults.standard.storedCount) {
    case true:
      if #available(iOS 14.0, *) {
        guard let firstScene = UIApplication.shared.windows.first?.windowScene else { return }
        SKStoreReviewController.requestReview(in: firstScene)
      } else {
        SKStoreReviewController.requestReview()
      }
    case false:
      break;
    }
  }
  
  func requestReviewInCurrentSceneOrIncrementCount() {
    incrementAppStoreReviewPointsCount()
    tryRequestReviewInCurrentScene()
  }
}

private extension UserDefaults {
  var storedCount: Int {
    get { UserDefaults.standard.integer(forKey: #function) }
    set { UserDefaults.standard.set(newValue, forKey: #function) }
  }
}
