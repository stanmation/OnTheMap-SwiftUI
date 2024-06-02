//
//  Coordinator.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 9/5/2024.
//

import SwiftUI

enum Page: Hashable, Equatable {
  case login
  case studentLocation(loginService: LoginService?)
  
  static func == (lhs: Page, rhs: Page) -> Bool {
    switch (lhs, rhs) {
    case (.login, .login): return true
    case (.studentLocation, .studentLocation): return true
    default: return false
    }
  }
  
  func hash(into hasher: inout Hasher) {
    switch self {
    case .login, .studentLocation:
      break
    }
  }
}

class Coordinator: ObservableObject {
  @Published var path = NavigationPath()
  
  func push(page: Page) {
    path.append(page)
  }
  
  @MainActor @ViewBuilder
  func build(page: Page) -> some View {
    switch page {
    case .login:
      LoginView(viewModel: LoginViewModel())

    case .studentLocation(let loginService):
      StudentLocationTabView(
        viewModel: StudentLocationViewModel(loginService: loginService ?? LoginService()))
    }
  }
}
