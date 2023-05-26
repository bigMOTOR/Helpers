//
//  ShimmerModifier.swift
//  
//
//  Created by Mykola Fiantsev on 27.05.2023.
//

import SwiftUI

public extension View {
  func shimmer(isActive: Bool = true, speed: Double = 0.15, angle: Angle = .init(degrees: 70), opacity: Double = 1.0) -> some View {
    return self.modifier(ShimmerModifier(isActive: isActive, speed: speed, angle: angle, opacity: opacity))
  }
}

private struct ShimmerModifier: ViewModifier {
  let isActive: Bool
  let speed: Double
  let angle: Angle
  let opacity: Double
  
  @ViewBuilder
  func body(content: Content) -> some View {
    if !isActive { content }
    
    content
      .opacity(opacity)
      .overlay(ShimmerView(speed: speed, angle: angle).mask(content))
  }
}

private struct ShimmerView: View {
  let speed: Double
  let angle: Angle
  @State private var _show = false
  
  var body: some View {
    GeometryReader { geo in
      Color.white
        .mask(Rectangle().fill(_gradient))
        .padding(-_calcSize(geo))
        .rotationEffect(angle)
        .offset(x: _calcOffset(geo), y: 0)
        .animation(_animation)
    }
    .onAppear { _show.toggle() }
  }
  
  private var _gradient: LinearGradient {
    let leading = Gradient.Stop(color: .clear, location: 0.35)
    let center = Gradient.Stop(color: Color.white.opacity(0.7), location: 0.45)
    let trailing = Gradient.Stop(color: .clear, location: 0.55)
    
    return LinearGradient(
      gradient: .init(stops: [leading, center, trailing]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
  
  private var _animation: Animation {
    Animation.default
      .speed(0.15)
      .delay(0)
      .repeatForever(autoreverses: false)
  }
  
  private func _calcOffset(_ geo: GeometryProxy) -> CGFloat {
    let size = _calcSize(geo)
    return (_show ? size : -size) * 2
  }
  
  private func _calcSize(_ geo: GeometryProxy) -> CGFloat {
    return max(geo.size.width, geo.size.height)
  }
}
