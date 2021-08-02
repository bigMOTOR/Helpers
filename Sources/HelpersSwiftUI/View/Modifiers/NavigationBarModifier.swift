//
//  NavigationBarModifier.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
  let backgroundColor: UIColor
  let tintColor: UIColor
  
  init(backgroundColor: UIColor, tintColor: UIColor) {
    self.backgroundColor = backgroundColor
    self.tintColor = tintColor
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
    coloredAppearance.backgroundColor = .clear
    
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = tintColor
  }
  
  func body(content: Content) -> some View {
    ZStack{
      content
      VStack {
        GeometryReader { geometry in
          Color(backgroundColor)
            .frame(height: geometry.safeAreaInsets.top)
            .edgesIgnoringSafeArea(.top)
          Spacer()
        }
      }
    }
  }
}
