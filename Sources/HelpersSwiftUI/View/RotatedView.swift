//
//  RotatedView.swift
//  
//
//  Created by Nikolay Fiantsev on 01.08.2021.
//

import SwiftUI

struct RotatedView<Rotated: View>: View {
  var view: Rotated
  var angle: Angle
  
  init(_ view: Rotated, angle: Angle) {
    self.view = view
    self.angle = angle
  }
  
  @State private var size: CGSize = .zero
  
  var body: some View {
    // Rotate the frame, and compute the smallest integral frame that contains it
    let newFrame = CGRect(origin: .zero, size: size)
      .offsetBy(dx: -size.width/2, dy: -size.height/2)
      .applying(.init(rotationAngle: CGFloat(angle.radians)))
      .integral
    
    return view
      .fixedSize()                    // Don't change the view's ideal frame
      ._captureSize(in: $size)        // Capture the size of the view's ideal frame
      .rotationEffect(angle)          // Rotate the view
      .frame(width: newFrame.width,   // And apply the new frame
             height: newFrame.height)
  }
}

private struct SizeKey: PreferenceKey {
  static let defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

private extension View {
  
  func _captureSize(in binding: Binding<CGSize>) -> some View {
    overlay(GeometryReader { geoReader in
      Color.clear.preference(key: SizeKey.self, value: geoReader.size)
    })
    .onPreferenceChange(SizeKey.self) { size in binding.wrappedValue = size }
  }
}
