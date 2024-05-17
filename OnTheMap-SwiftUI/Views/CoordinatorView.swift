//
//  CoordinatorView.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 9/5/2024.
//

import SwiftUI

struct CoordinatorView: View {
  @StateObject var coordinator = Coordinator()
  
  var body: some View {
    NavigationStack(path: $coordinator.path) {
      coordinator.build(page: .login)
        .navigationDestination(for: Page.self) { page in
          coordinator.build(page: page)
        }
    }
    .environmentObject(coordinator)
  }
}
