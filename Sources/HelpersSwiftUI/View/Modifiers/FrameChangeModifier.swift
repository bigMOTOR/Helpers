//
//  FrameChangeModifier.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import SwiftUI

struct FrameChangeModifier: ViewModifier {
  let isEnabled: Bool
  let frameHandler: (CGRect)->()
  
  func body(content: Content) -> some View {
    guard isEnabled else { return AnyView(content) }
    
    return AnyView(content.background(GeometryReader { geometry in
      Color.clear.beforeReturn {
        frameHandler(geometry.frame(in: .global))
      }
    }))
  }
}

private extension View {
  func beforeReturn(_ onBeforeReturn: ()->()) -> Self {
    onBeforeReturn()
    return self
  }
}
