//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by Stanley Darmawan on 30/4/2024.
//  Copyright © 2024 Stanley Darmawan. All rights reserved.
//

struct SessionResponse: Decodable {
    let account: Account
    let session: Session
    
    struct Account: Decodable {
        let key: String
    }
    
    struct Session: Decodable {
        let id: String
    }
}
