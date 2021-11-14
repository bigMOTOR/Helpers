//
//  ViewExtension.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import SwiftUI

public extension View {
  
  func noSeparator() -> some View {
    self.modifier(NoSeparatorListItem())
  }
  
  @available(iOS, introduced: 14)
  func navigationBarColors(background: Color, tint: Color) -> some View {
    self.modifier(NavigationBarModifier(backgroundColor: UIColor(background), tintColor: UIColor(tint)))
  }
  
  func onFrameChange(enabled isEnabled: Bool = true, frameHandler: @escaping (CGRect)->()) -> some View {
    self.modifier(FrameChangeModifier(isEnabled: isEnabled, frameHandler: frameHandler))
  }
  
  func shimmer(isActive: Bool = true, speed: Double = 0.15, angle: Angle = .init(degrees: 70), opacity: Double = 1.0) -> some View {
    return self.modifier(ShimmerModifier(isActive: isActive, speed: speed, angle: angle, opacity: opacity))
  }
  
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
  
  func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
    return self.modifier(OnRotateActionViewModifier(action: action))
  }
  
  func rotateHandling(anchor: UnitPoint = .center) -> some View {
    return self.modifier(RotationHandlerModifier(anchor: anchor))
  }
  
  func rotated(_ angle: Angle) -> some View {
    RotatedView(self, angle: angle)
  }
  
  func blink(on state: Binding<Bool>, duration: Double = 0.1) -> some View {
    return self.modifier(BlinkingModifier(state: state, duration: duration))
  }
  
  /// Applies the given transform if the given condition evaluates to `true`.
  @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
    if condition() {
      transform(self)
    } else {
      self
    }
  }
  
}
