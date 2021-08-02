//
//  PurchasesComposable.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import Foundation
import Combine
import ComposableArchitecture
import Purchases

public extension Purchases {
  static var purchaserInfo: Effect<Purchases.PurchaserInfo, Error> {
    let initialPurchaserInfo = Effect.future { (result: @escaping (Result<Purchases.PurchaserInfo, Error>)->Void) in
      Purchases.shared.purchaserInfo { info, error in
        switch info {
        case .some(let purchaserInfo):
          result(.success(purchaserInfo))
        case .none:
          result(.failure(error ?? IAPError.noPurchaserInfo))
        }
      }
    }
    
    let purchasesDelegate = PurchasesDelegateProxy()
    let purchaserInfoUpdates = purchasesDelegate._didReceiveUpdatedSubject.eraseToAnyPublisher()
      .setFailureType(to: Error.self)
      .eraseToEffect()
    
    return .merge(
      initialPurchaserInfo,
      purchaserInfoUpdates
    )
    .removeDuplicates()
    .eraseToEffect()
    .cancellable(id: PurchaserInfoId())
  }
}

private struct PurchaserInfoId: Hashable {}

final class PurchasesDelegateProxy: NSObject, PurchasesDelegate {
  let _didReceiveUpdatedSubject = PassthroughSubject<Purchases.PurchaserInfo, Never>()
  
  func purchases(_ purchases: Purchases, didReceiveUpdated purchaserInfo: Purchases.PurchaserInfo) {
    _didReceiveUpdatedSubject.send(purchaserInfo)
  }
}
