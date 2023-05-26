//
//  RoundedCorner.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import SwiftUI

#if !os(macOS)
public extension View {
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}

private struct RoundedCorner: Shape {
  let radius: CGFloat
  let corners: UIRectCorner
  
  init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
    self.radius = radius
    self.corners = corners
  }
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}
#endif
