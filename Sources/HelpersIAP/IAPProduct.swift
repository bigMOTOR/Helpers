//
//  IAPProduct.swift
//  
//
//  Created by Nikolay Fiantsev on 02.08.2021.
//

import Foundation

public struct IAPProduct: Equatable {
  
  public struct Period: Equatable {
    public enum Unit: String {
      case day
      case week
      case month
      case year
    }
    
    public let numberOfUnits: Int
    public let unit: Unit
    
    public init(numberOfUnits: Int, unit: IAPProduct.Period.Unit) {
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
  
  public let productIdentifier: String
  public let localizedDescription: String
  public let localizedPriceString: String
  public let price: Decimal
  public let currencyCode: String?
  public let subscriptionPeriod: Period?
  public let introductoryPeriod: Period?
}

#if DEBUG
public extension IAPProduct {
  static func mock(unit: IAPProduct.Period.Unit) -> IAPProduct {
    return IAPProduct(productIdentifier: "productIdentifier",
                      localizedDescription: "localizedDescription",
                      localizedPriceString: "$29.99",
                      price: 29.99,
                      currencyCode: "USD",
                      subscriptionPeriod: Period(numberOfUnits: 1, unit: unit),
                      introductoryPeriod: Period(numberOfUnits: 3, unit: .day))
  }
}
#endif
