//
//  UserDataResponse.swift
//  OnTheMap
//
//  Created by Stanley Darmawan on 30/4/2024.
//  Copyright © 2024 Stanley Darmawan. All rights reserved.
//

struct UserDataResponse: Decodable {
    let lastName: String
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
