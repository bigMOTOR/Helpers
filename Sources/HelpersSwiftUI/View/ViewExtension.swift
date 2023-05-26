//
//  ViewExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import SwiftUI

public extension View {
  /// Applies the given transform if the given condition evaluates to `true`.
  @ViewBuilder
  func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
    if condition() {
      transform(self)
    } else {
      self
    }
  }
}
