//
//  Coordinator.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 9/5/2024.
//

import SwiftUI

enum Page: Hashable {
  case login
  case studentLocation
}

class Coordinator: ObservableObject {
  @Published var path = NavigationPath()
  
  @MainActor var loginViewModel: LoginViewModel?
  @MainActor var loginService: LoginService?
  
  @MainActor var studentLocationViewModel: StudentLocationViewModel?
  @MainActor var studentLocationService: StudentLocationService?
  
  func push(page: Page) {
    path.append(page)
  }
  
  @MainActor @ViewBuilder
  func build(page: Page) -> some View {
    switch page {
    case .login:
      LoginView(viewModel: constructLoginViewModelAndDependencies())
    case .studentLocation:
      StudentLocationTabView(viewModel: constructStudentLocationViewModelAndDependencies())
    }
  }
  
  @MainActor
  private func constructLoginViewModelAndDependencies() -> LoginViewModel {
    self.loginViewModel ?? LoginViewModel(loginService: LoginService())
  }
  
  @MainActor
  private func constructStudentLocationViewModelAndDependencies() -> StudentLocationViewModel {
    studentLocationViewModel
    ?? StudentLocationViewModel(studentLocationService: studentLocationService ?? StudentLocationService(),
                                loginService: loginService ?? LoginService())
  }
}
