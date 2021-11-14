//
//  ColorExtensions.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import SwiftUI

// MARK: UIKit Colors
public extension Color {
  static let systemBackground = Color(UIColor.systemBackground)
  static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
  static let tertiarySystemFill = Color(UIColor.tertiarySystemFill)
  static let quaternarySystemFill = Color(UIColor.quaternarySystemFill)
  
  static let label = Color(UIColor.label)
  static let secondaryLabel = Color(UIColor.secondaryLabel)
  static let tertiaryLabel = Color(UIColor.tertiaryLabel)
  
  static let opaqueSeparator = Color(UIColor.separator.withAlphaComponent(0.5))
  
  static let systemGray2 = Color(UIColor.systemGray2)
}

public extension Color {
  static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
    return UIColor { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .dark:
        return dark
      default:
        return light
      }
    }
  }
}
