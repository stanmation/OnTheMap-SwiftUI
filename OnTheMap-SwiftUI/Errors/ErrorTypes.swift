//
//  ErrorTypes.swift
//  OnTheMap
//
//  Created by Stanley Darmawan on 30/4/2024.
//  Copyright © 2024 Stanley Darmawan. All rights reserved.
//

enum ServerError: Error {
  case credentialsAreNotCorrect(String)
  case technicalError(String)
  case noInternet
}
