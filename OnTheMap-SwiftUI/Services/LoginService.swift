//
//  LoginService.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 3/5/2024.
//

import Foundation

class LoginService: ObservableObject {
  private let urlSession = URLSession.shared
  private let jsonDecoder = JSONDecoder()
  
  func getSession(username: String, password: String) async throws -> SessionResponse {
    let url = URL(string: "https://onthemap-api.udacity.com/v1/session")!
    
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
    
    do {
      let (data, response) = try await urlSession.data(for: request)
      
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
            statusCode >= 200 && statusCode <= 299 else {
        print("Your request returned a status code other than 2xx!")
        throw ServerError.credentialsAreNotCorrect("email or password is not correct")
      }
      let range = 5..<data.count
      let newData = data.subdata(in: range)
      let sessionResponse = try JSONDecoder().decode(SessionResponse.self, from: newData)
      return sessionResponse
    } catch {
      if (error as NSError).code ==
          -1009 {
        throw ServerError.noInternet
      } else {
        throw ServerError.technicalError("A technical Error has occured")
      }
    }
  }
  
  func getPublicUserData(session: SessionResponse) async throws -> UserDataResponse {
    let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/users/\(session.account.key)")!)
    
    do {
      let (data, response) = try await urlSession.data(for: request)
      
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
            statusCode >= 200 && statusCode <= 299 else {
        print("Your request returned a status code other than 2xx!")
        throw ServerError.technicalError("Failed in getting your data")
      }
      
      let range = 5..<data.count
      let newData = data.subdata(in: range)
      let userDataResponse = try JSONDecoder().decode(UserDataResponse.self, from: newData)
      return userDataResponse
    } catch {
      if (error as NSError).code ==
          -1009 {
        throw ServerError.noInternet
      } else {
        throw ServerError.technicalError("A technical Error has occured")
      }
    }
  }
  
  func deleteSession() async throws {
    var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
    request.httpMethod = "DELETE"
    var xsrfCookie: HTTPCookie? = nil
    let sharedCookieStorage = HTTPCookieStorage.shared
    for cookie in sharedCookieStorage.cookies! {
      if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
    }
    if let xsrfCookie = xsrfCookie {
      request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
    }

    do {
      let (data, response) = try await urlSession.data(for: request)
      if let statusCode = (response as? HTTPURLResponse)?.statusCode,
         statusCode < 200 && statusCode > 299 {
        throw ServerError.technicalError("Failed in getting your data")
      }
    } catch {
      if (error as NSError).code ==
          -1009 {
        throw ServerError.noInternet
      } else {
        throw ServerError.technicalError("A technical Error has occured")
      }
    }
  }
}
