//
//  ContentViewViewModel.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 3/5/2024.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
  @Published var errorWrapper: ErrorWrapper?
  @Published var nextPage: Page?
  
  private let loginService: LoginService?

  init(loginService: LoginService = LoginService()) {
    self.loginService = loginService
  }
  
  func login(email: String, password: String) {
    Task {
      do {
        if let session = try await loginService?.getSession(username: email, password: password) {
          _ = try await loginService?.getPublicUserData(session: session)
          nextPage = .studentLocation
        }
      } catch let error as ServerError {
        errorWrapper = ErrorWrapper(serverError: error)
      }
    }
  }
}
