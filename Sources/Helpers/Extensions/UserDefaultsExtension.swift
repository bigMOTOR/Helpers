//
//  UserDefaultsExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import Foundation

public extension UserDefaults {
  func setCodable<T: Codable>(_ value: T, for key: String) {
    let data = try? JSONEncoder().encode(value)
    set(data, forKey: key)
  }
  
  func codable<T: Codable>(for key: String) -> T? {
    let data = data(forKey: key)
    return data.flatMap { try? JSONDecoder().decode(T.self, from: $0) }
  }
  
  func deleteValue(key: String) {
    set(nil, forKey: key)
  }
}
