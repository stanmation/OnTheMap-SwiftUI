//
//  ErrorWrapper.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 4/5/2024.
//

import SwiftUI

struct ErrorWrapper: Identifiable {
  let id = UUID()
  let title: String
  let message: String
  
  init(title: String, message: String) {
    self.title = title
    self.message = message
  }
  
  init?(serverError: ServerError) {
    switch serverError {
    case .credentialsAreNotCorrect(let errorMessage), .technicalError(let errorMessage):
      self.init(title: "Error", message: errorMessage)
    case .noInternet:
      self.init(title: "Error", message: "No Internet Connection")
    }
  }
}
