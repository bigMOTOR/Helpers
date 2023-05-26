//
//  OnRotateActionViewModifier.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import SwiftUI

#if os(iOS)
public extension View {
  func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
    return self.modifier(OnRotateActionViewModifier(action: action))
  }
}

private struct OnRotateActionViewModifier: ViewModifier {
  let action: (UIDeviceOrientation) -> Void
  
  func body(content: Content) -> some View {
    content
      .onAppear()
      .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
        action(UIDevice.current.orientation)
      }
  }
}
#endif
