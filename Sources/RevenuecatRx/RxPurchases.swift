//
//  RxPurchases.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import Foundation
import Purchases
import RxSwift
import RxCocoa

public extension Reactive where Base: Purchases {
  
  var delegate: DelegateProxy<Purchases, PurchasesDelegate> {
    return PurchasesDelegateProxy.proxy(for: base)
  }

  var didReceiveUpdatedPurchaserInfo: Observable<Purchases.PurchaserInfo> {
    return PurchasesDelegateProxy.proxy(for: base)
      .purchaserInfoSubject
      .distinctUntilChanged()
  }
  
}

final class PurchasesDelegateProxy: DelegateProxy<Purchases, PurchasesDelegate>, DelegateProxyType, PurchasesDelegate {
  
  let purchaserInfoSubject = PublishSubject<Purchases.PurchaserInfo>()

  init(purchases: Purchases) {
    super.init(parentObject: purchases, delegateProxy: PurchasesDelegateProxy.self)
  }
  
  static func registerKnownImplementations() {
    self.register { PurchasesDelegateProxy(purchases: $0) }
  }
  
  func purchases(_ purchases: Purchases, didReceiveUpdated purchaserInfo: Purchases.PurchaserInfo) {
    purchaserInfoSubject.onNext(purchaserInfo)
  }

}

extension Purchases: HasDelegate {
  public typealias Delegate = PurchasesDelegate
}
