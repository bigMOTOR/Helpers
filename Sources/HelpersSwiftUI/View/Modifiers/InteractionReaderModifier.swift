// swiftlint:disable:this file_name
//
//  InteractionReaderModifier.swift
//
//
//  Created by Mykola Fiantsev on 17.03.2024.
//

import SwiftUI

/// Combine two different kind of gestures onTap and onLongPress leads to long time to recognise LongPress. Here is the solution to having some multi gesture in one. https://stackoverflow.com/questions/66844260/swiftui-longpressgesture-takes-too-long-to-recognize-when-tapgesture-also-presen
public extension View {
  @available(iOS, introduced: 14)
  func interactionReader(longPressSensitivity: Int, tapAction: @escaping () -> Void, longPressAction: @escaping () -> Void, scaleEffect: Bool = true) -> some View {
    return self
      .modifier(InteractionReaderViewModifier(longPressSensitivity: longPressSensitivity, tapAction: tapAction, longPressAction: longPressAction, scaleEffect: scaleEffect))
  }
}

@available(iOS, introduced: 14)
private struct InteractionReaderViewModifier: ViewModifier {
  var longPressSensitivity: Int
  var tapAction: () -> Void
  var longPressAction: () -> Void
  var scaleEffect = true
  
  @State private var isPressing = Bool()
  @State private var currentDismissId = DispatchTime.now()
  @State private var lastInteractionKind = String()
  
  func body(content: Content) -> some View {
    let processedContent = content
      .gesture(gesture)
      .onChange(of: isPressing) { _ in
        currentDismissId = DispatchTime.now() + .milliseconds(longPressSensitivity)
        let dismissId: DispatchTime = currentDismissId
        
        if isPressing {
          DispatchQueue.main.asyncAfter(deadline: dismissId) {
            if isPressing {
              if dismissId == currentDismissId {
                lastInteractionKind = longPressTag
                longPressAction()
              }
            }
          }
        } else {
          if lastInteractionKind != longPressTag {
            lastInteractionKind = tapTag
            tapAction()
          }
          
          DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            lastInteractionKind = noneTag
          }
        }
      }
    
    return Group {
      if scaleEffect {
        processedContent.scaleEffect(lastInteractionKind == longPressTag ? 1.5 : (lastInteractionKind == tapTag ? 0.8 : 1.0))
      } else {
        processedContent
      }
    }
  }
  
  var gesture: some Gesture {
    DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
      .onChanged { _ in if !isPressing { isPressing = true } }
      .onEnded { _ in isPressing = false }
  }
}

private let longPressTag = "longPress"
private let tapTag = "tap"
private let noneTag = "none"
