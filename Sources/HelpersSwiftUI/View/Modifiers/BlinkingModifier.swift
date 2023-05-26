//
//  BlinkingModifier.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import SwiftUI

public extension View {
  func blink(on state: Binding<Bool>, duration: Double = 0.1) -> some View {
    return self.modifier(BlinkingModifier(state: state, duration: duration))
  }
}

private struct BlinkingModifier: ViewModifier {
  let state: Binding<Bool>
  let duration: Double
  
  // internal wrapper is needed because there is no didFinish of Animation now
  private var blinking: Binding<Bool> {
    Binding<Bool>(
      get: {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
          self.state.wrappedValue = false
        }
        return self.state.wrappedValue
      },
      set: { newValue in
        self.state.wrappedValue = newValue
      }
    )
  }
  
  func body(content: Content) -> some View {
    content
      .opacity(blinking.wrappedValue ? 0 : 1)
  }
}
