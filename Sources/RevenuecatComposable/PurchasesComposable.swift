//
//  PurchasesComposable.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import Foundation
import Combine
import ComposableArchitecture
import RevenueCat

public extension Purchases {
  static var customerInfo: Effect<RevenueCat.CustomerInfo, Error> {
    let initialPurchaserInfo = Effect.future { (result: @escaping (Result<RevenueCat.CustomerInfo, Error>)->Void) in
      Purchases.shared.getCustomerInfo { info, error in
        switch info {
        case .some(let purchaserInfo):
          result(.success(purchaserInfo))
        case .none:
          result(.failure(error ?? IAPError.noPurchaserInfo))
        }
      }
    }
    
    let purchasesDelegate = PurchasesDelegateProxy()
    let customerInfoUpdates = purchasesDelegate._didReceiveUpdatedSubject.eraseToAnyPublisher()
      .setFailureType(to: Error.self)
      .eraseToEffect()
    
    return .merge(
      initialPurchaserInfo,
      customerInfoUpdates
    )
    .removeDuplicates()
    .eraseToEffect()
    .cancellable(id: PurchaserInfoId())
  }
}

private struct PurchaserInfoId: Hashable {}

final class PurchasesDelegateProxy: NSObject, PurchasesDelegate {
  let _didReceiveUpdatedSubject = PassthroughSubject<RevenueCat.CustomerInfo, Never>()
  
  func purchases(_ purchases: Purchases, receivedUpdated customerInfo: RevenueCat.CustomerInfo) {
    _didReceiveUpdatedSubject.send(customerInfo)
  }
}
