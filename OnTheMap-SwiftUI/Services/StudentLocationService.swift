//
//  StudentLocationService.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 7/5/2024.
//

import Foundation

class StudentLocationService: ObservableObject {
  private let urlSession = URLSession.shared
  private let jsonDecoder = JSONDecoder()
  
  func getStudentLocations() async throws -> [Student] {
    var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
    request.addValue(Constants.OTMParameterValues.RestApiKey, forHTTPHeaderField: Constants.OTMParameterKeys.RestApiKey)
    
    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
            statusCode >= 200 && statusCode <= 299 else {
        print("Your request returned a status code other than 2xx!")
        throw ServerError.technicalError("Failed in retrieving data, please check your network connection or the data exists")
      }
      
      let studentsResponse = try JSONDecoder().decode(StudentResponse.self, from: data)
      return studentsResponse.results
    } catch {
      print(error)
      if (error as NSError).code ==
          -1009 {
        throw ServerError.noInternet
      } else {
        throw ServerError.technicalError("A technical Error has occured")
      }
    }
  }
}
