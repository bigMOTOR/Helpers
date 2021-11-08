//
//  NoSeparatorListItem.swift
//  
//
//  Created by Nikolay Fiantsev on 30.07.2021.
//

import SwiftUI

struct NoSeparatorListItem: ViewModifier {
  func body(content: Content) -> some View {
    if #available(iOS 15, *) {
      content.listRowSeparator(.hidden)
    } else {
      content
        .padding(.horizontal)
        .padding(.vertical, 5)
        .listRowInsets(EdgeInsets())
        .background(Color(UIColor.systemBackground))
    }
  }
}
