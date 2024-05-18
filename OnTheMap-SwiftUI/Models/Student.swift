//
//  Student.swift
//  OnTheMap
//
//  Created by Stanley Darmawan on 2/09/2016.
//  Copyright © 2016 Stanley Darmawan. All rights reserved.
//

import UIKit
import MapKit

struct StudentResponse: Decodable {
  let results: [Student]
}

struct Student: Decodable, Identifiable {
  let id = UUID()
  let firstName: String
  let lastName: String
  let mediaURL: String
  let latitude: Double
  let longitude: Double
}


