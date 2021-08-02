//
//  IAPError.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import Foundation

public enum IAPError: Error {
  case noPurchaserInfo
  case productNotAvailable
  case unknown
}
