//
//  UUIDExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation

public extension UUID {
  /// output as lower case characters according to rfc https://www.ietf.org/rfc/rfc4122.txt
  var uuidStringLowercased: String {
    return uuidString.lowercased()
  }
}
