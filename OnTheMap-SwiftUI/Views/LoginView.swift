//
//  ContentView.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 2/5/2024.
//

import SwiftUI

struct LoginView: View {
  @StateObject private var viewModel: LoginViewModel
  @EnvironmentObject private var coordinator: Coordinator
  
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var isActionCompleted = false
  
  init(viewModel: LoginViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    ZStack {
      Color.gray
        .opacity(0.3)
        .edgesIgnoringSafeArea(.all)
      VStack {
        TextField("Email", text: $email)
          .disableAutocorrection(true)
          .autocapitalization(.none)
          .inputTextFieldStyle()
        
        SecureField("Password", text: $password)
          .inputTextFieldStyle()
        
        Button(action: {
          viewModel.login(email: email, password: password)
        }) {
          Text("Submit")
            .bold()
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .cornerRadius(8)
        }
      }
      .padding(.vertical)
      .padding(.horizontal, 40)
    }
    .alert(item: $viewModel.errorWrapper) { errorWrapper in
      Alert(title: Text(errorWrapper.title),
            message: Text(errorWrapper.message),
            dismissButton: .default(Text("OK")))
    }
    .onReceive(viewModel.$nextPage, perform: { nextPage in
      if let nextPage {
        coordinator.push(page: nextPage)
      }
    })
  }
}

#Preview {
  return LoginView(viewModel: LoginViewModel())
}
