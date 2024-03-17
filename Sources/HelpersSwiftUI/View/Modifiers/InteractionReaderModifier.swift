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
  var scaleEffect: Bool = true
  
  @State private var isPressing: Bool = Bool()
  @State private var currentDismissId: DispatchTime = DispatchTime.now()
  @State private var lastInteractionKind: String = String()
  
  func body(content: Content) -> some View {
    let processedContent = content
      .gesture(gesture)
      .onChange(of: isPressing) { newValue in
        currentDismissId = DispatchTime.now() + .milliseconds(longPressSensitivity)
        let dismissId: DispatchTime = currentDismissId
        
        if isPressing {
          DispatchQueue.main.asyncAfter(deadline: dismissId) {
            if isPressing {
              if (dismissId == currentDismissId) {
                lastInteractionKind = "longPress"
                longPressAction()
              }
            }
          }
        }
        else {
          if (lastInteractionKind != "longPress") {
            lastInteractionKind = "tap"
            tapAction()
          }
          
          DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            lastInteractionKind = "none"
          }
        }
      }
    
    return Group {
      if scaleEffect {
        processedContent.scaleEffect(lastInteractionKind == "longPress" ? 1.5: (lastInteractionKind == "tap" ? 0.8 : 1.0))
      } else {
        processedContent
      }
    }
  }
  
  var gesture: some Gesture {
    DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
      .onChanged() { _ in if !isPressing { isPressing = true } }
      .onEnded() { _ in isPressing = false }
  }
}

