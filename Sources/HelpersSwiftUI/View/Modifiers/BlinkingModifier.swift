//
//  BlinkingModifier.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import SwiftUI

struct BlinkingModifier: ViewModifier {
  let state: Binding<Bool>
  let duration: Double
  
  // internal wrapper is needed because there is no didFinish of Animation now
  private var blinking: Binding<Bool> {
    Binding<Bool>(get: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                      self.state.wrappedValue = false
                    }
                    return self.state.wrappedValue },
                  set: {
                      self.state.wrappedValue = $0
                    })
  }
  
  func body(content: Content) -> some View {
    content
      .opacity(blinking.wrappedValue ? 0 : 1)
  }
}
