//
//  IAPProduct.swift
//  
//
//  Created by Nikolay Fiantsev on 02.08.2021.
//

import Foundation

struct IAPProduct: Equatable {
  
  struct Period: Equatable {
    enum Unit: String {
      case day
      case week
      case month
      case year
    }
    
    let numberOfUnits: Int
    let unit: Unit
    
    init(numberOfUnits: Int, unit: IAPProduct.Period.Unit) {
      switch (numberOfUnits, unit) {
      case (7, .day):
        self.numberOfUnits = 1
        self.unit = .week
      default:
        self.numberOfUnits = numberOfUnits
        self.unit = unit
      }
    }
    
  }
  
  let productIdentifier: String
  let localizedDescription: String
  let localizedPriceString: String
  let price: NSDecimalNumber
  let priceLocale: Locale
  let subscriptionPeriod: Period?
  let introductoryPeriod: Period?
}

#if DEBUG
extension IAPProduct {
  static func mock(unit: IAPProduct.Period.Unit) -> IAPProduct {
    return IAPProduct(productIdentifier: "productIdentifier",
                      localizedDescription: "localizedDescription",
                      localizedPriceString: "$29.99",
                      price: 29.99,
                      priceLocale: .current,
                      subscriptionPeriod: Period(numberOfUnits: 1, unit: unit),
                      introductoryPeriod: Period(numberOfUnits: 3, unit: .day))
  }
}
#endif
