//
//  RotationHandlerModifier.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import SwiftUI

#if os(iOS)
public extension View {
  func rotateHandling(anchor: UnitPoint = .center) -> some View {
    return self.modifier(RotationHandlerModifier(anchor: anchor))
  }
}

private struct RotationHandlerModifier: ViewModifier {
  private let _anchor: UnitPoint
  @State private var _rotation = 0.0

  init(anchor: UnitPoint) {
    _anchor = anchor
  }

  func body(content: Content) -> some View {
    return content
      .rotationEffect(.degrees(_rotation), anchor: _anchor)
      .animation(_animation)
      .onRotate { newOrientation in
        switch newOrientation.isLandscape {
        case true where newOrientation == .landscapeRight:
          _rotation = -90
        case true:
          _rotation = 90
        case false where newOrientation == .portraitUpsideDown:
          _rotation = -180
        case false:
          _rotation = 0
        }
      }
  }

  private var _animation: Animation {
    Animation.linear
      .speed(0.7)
  }
}
#endif
