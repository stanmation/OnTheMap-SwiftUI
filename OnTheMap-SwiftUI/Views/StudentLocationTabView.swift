//
//  TabView.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 4/5/2024.
//

import SwiftUI

struct StudentLocationTabView: View {
  @Environment(\.presentationMode) var presentationMode
  @StateObject private var viewModel: StudentLocationViewModel

  init(viewModel: StudentLocationViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    TabView {
      MapDisplayView()
        .tabItem {
          Label("Map", systemImage: "mappin.and.ellipse.circle")
        }
        .environmentObject(viewModel)
      ListDisplayView()
        .tabItem {
          Label("List", systemImage: "list.star")
        }
        .environmentObject(viewModel)
    }
    .navigationBarItems(
      leading: Button(action: {
        viewModel.logout()
      }) {
        Text("Logout")
      },
      trailing: Button(action: {
        print("refresh")
      }) {
        Image(systemName: "arrow.clockwise")
      }
    )
    .navigationBarBackButtonHidden()
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("Student Locations")
    .alert(item: $viewModel.errorWrapper) { errorWrapper in
      Alert(title: Text(errorWrapper.title),
            message: Text(errorWrapper.message),
            dismissButton: .default(Text("OK")))
    }
    .onReceive(viewModel.$shouldLogout, perform: { shouldLogout in
      if shouldLogout {
        presentationMode.wrappedValue.dismiss()
      }
    })
    .onAppear {
      viewModel.loadStudentLocations()
    }
  }
}

#Preview {
  StudentLocationTabView(viewModel: StudentLocationViewModel())
}
