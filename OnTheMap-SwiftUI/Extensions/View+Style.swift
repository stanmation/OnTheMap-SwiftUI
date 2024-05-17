//
//  View+Style.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 2/5/2024.
//

import SwiftUI

extension View {
  func inputTextFieldStyle() -> some View {
    modifier(InputTextFieldModifier())
  }
}

struct InputTextFieldModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding()
      .background(Color.white)
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.gray, lineWidth: 1)
      )
      .padding(.vertical, 10)
  }
}


