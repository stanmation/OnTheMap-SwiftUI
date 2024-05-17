//
//  OnTheMap_SwiftUIApp.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 2/5/2024.
//

import SwiftUI

fileprivate let loginService = LoginService()

@main
struct OnTheMap_SwiftUIApp: App {
  var body: some Scene {
    WindowGroup {
      CoordinatorView()
//      LoginView()
//        .environmentObject(loginService)
    }
  }
}
