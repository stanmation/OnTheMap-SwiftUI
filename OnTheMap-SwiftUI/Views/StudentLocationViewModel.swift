//
//  MainViewModel.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 7/5/2024.
//

import Foundation
import CoreLocation

struct MarkerModel: Identifiable {
  var id: String = UUID().uuidString
  var location: CLLocationCoordinate2D
  var title: String
}

@MainActor
class StudentLocationViewModel: ObservableObject {
  @Published var errorWrapper: ErrorWrapper?
  @Published var markerModels: [MarkerModel] = []
  @Published var students: [Student] = []
  @Published var shouldLogout = false
  
  private let studentLocationService: StudentLocationService
  private let loginService: LoginService
  
  init(studentLocationService: StudentLocationService = StudentLocationService(),
       loginService: LoginService = LoginService()) {
    self.studentLocationService = studentLocationService
    self.loginService = loginService
  }
  
  func loadStudentLocations() {
    Task {
      do {
        students = try await studentLocationService.getStudentLocations()
        markerModels = []
        for student in students {
          let locationCoordinate = CLLocationCoordinate2D(latitude: student.latitude, longitude: student.longitude)
          let markerModel = MarkerModel(location: locationCoordinate, title: student.firstName + " " + student.lastName)
          markerModels.append(markerModel)
        }
      } catch let error as ServerError {
        errorWrapper = ErrorWrapper(serverError: error)
      }
    }
  }
  
  func logout() {
    Task {
      do {
        try await loginService.deleteSession()
        shouldLogout = true
      } catch let error as ServerError {
        errorWrapper = ErrorWrapper(serverError: error)
      }
    }
  }
}
