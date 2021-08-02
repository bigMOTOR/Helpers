//
//  NoSeparatorListItem.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import SwiftUI

struct NoSeparatorListItem: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.horizontal)
      .padding(.vertical, 5)
      .listRowInsets(EdgeInsets())
      .background(Color(UIColor.systemBackground))
  }
}
