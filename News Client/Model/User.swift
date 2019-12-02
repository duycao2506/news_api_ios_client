//
//  User.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation

class User {
    static let invalidPassword : Error = NSError.init(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey : "Invalid password"])
    var username : String = ""
    var password : String = ""
    
    init(username : String, password : String) throws {
        self.username = username
        guard let password = password.data(using: .utf8)?.base64EncodedString() else {
            throw User.invalidPassword
            return
        }
        self.password = password
    }
}
