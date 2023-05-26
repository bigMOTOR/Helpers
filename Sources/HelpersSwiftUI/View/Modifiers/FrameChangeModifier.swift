//
//  FrameChangeModifier.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import SwiftUI

public extension View {
  func onFrameChange(enabled isEnabled: Bool = true, frameHandler: @escaping (CGRect)->Void) -> some View {
    self.modifier(FrameChangeModifier(isEnabled: isEnabled, frameHandler: frameHandler))
  }
}

private struct FrameChangeModifier: ViewModifier {
  let isEnabled: Bool
  let frameHandler: (CGRect)->Void
  
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
  func beforeReturn(_ onBeforeReturn: ()->Void) -> Self {
    onBeforeReturn()
    return self
  }
}
