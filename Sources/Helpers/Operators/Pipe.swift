//
//  Pipe.swift
//  
//
//  Created by Nikolay Fiantsev on 25.05.2022.
//

import Foundation

precedencegroup CompositionPrecedence {
  associativity: left
}

infix operator |> : CompositionPrecedence

public func |> <A, B, C>(f: @escaping (A)->B, g: @escaping (B)->C) -> (A)->C {
  return { a -> C in
    g(f(a))
  }
}
