//
//  RxPurchases.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import Foundation
import RevenueCat
import RxSwift
import RxCocoa

public extension Reactive where Base: Purchases {
  
  var delegate: DelegateProxy<Purchases, PurchasesDelegate> {
    return PurchasesDelegateProxy.proxy(for: base)
  }

  var didReceiveUpdatedCustomerInfo: Observable<RevenueCat.CustomerInfo> {
    return PurchasesDelegateProxy.proxy(for: base)
      .customerInfoSubject
      .distinctUntilChanged()
  }
  
}

final class PurchasesDelegateProxy: DelegateProxy<Purchases, PurchasesDelegate>, DelegateProxyType, PurchasesDelegate {
  
  let customerInfoSubject = PublishSubject<RevenueCat.CustomerInfo>()

  init(purchases: Purchases) {
    super.init(parentObject: purchases, delegateProxy: PurchasesDelegateProxy.self)
  }
  
  static func registerKnownImplementations() {
    self.register { PurchasesDelegateProxy(purchases: $0) }
  }
  
  func purchases(_ purchases: Purchases, receivedUpdated customerInfo: RevenueCat.CustomerInfo) {
    customerInfoSubject.onNext(customerInfo)
  }

}

extension Purchases: HasDelegate {
  public typealias Delegate = PurchasesDelegate
}
