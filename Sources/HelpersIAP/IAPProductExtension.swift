//
//  IAPProductExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 03.08.2021.
//

import Foundation
import RevenueCat

extension IAPProduct {
  public init(_ package: RevenueCat.Package) {
    self.productIdentifier = package.storeProduct.productIdentifier
    self.localizedDescription = package.storeProduct.localizedDescription
    self.localizedPriceString = package.localizedPriceString
    self.price = package.storeProduct.price
    self.introductoryPeriod = package.storeProduct.introductoryDiscount.map(\.subscriptionPeriod).map(IAPProduct.Period.init)
    self.subscriptionPeriod = package.storeProduct.subscriptionPeriod.map(IAPProduct.Period.init)
  }
}

private extension IAPProduct.Period {
  init(period: SubscriptionPeriod) {
    self = .init(numberOfUnits: period.value, unit: .init(unit: period.unit))
  }
}

private extension IAPProduct.Period.Unit {
  init(unit: SubscriptionPeriod.Unit) {
    switch unit {
    case .day:
      self = .day
    case .week:
      self = .week
    case .month:
      self = .month
    case .year:
      self = .year
    @unknown default:
      fatalError("Unhandled case")
    }
  }
}
