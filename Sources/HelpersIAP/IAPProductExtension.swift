//
//  IAPProductExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 03.08.2021.
//

import Foundation
import Purchases

extension IAPProduct {
  public init(_ package: Purchases.Package) {
    self.productIdentifier = package.product.productIdentifier
    self.localizedDescription = package.product.localizedDescription
    self.localizedPriceString = package.localizedPriceString
    self.price = package.product.price
    self.priceLocale = package.product.priceLocale
    self.introductoryPeriod = package.product.introductoryPrice.map { IAPProduct.Period(period: $0.subscriptionPeriod) }
    self.subscriptionPeriod = package.product.subscriptionPeriod.map { IAPProduct.Period(period: $0) }
  }
}

private extension IAPProduct.Period {
  init(period: SKProductSubscriptionPeriod) {
    self = .init(numberOfUnits: period.numberOfUnits, unit: IAPProduct.Period.Unit(unit: period.unit))
  }
}

private extension IAPProduct.Period.Unit {
  init(unit: SKProduct.PeriodUnit) {
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
