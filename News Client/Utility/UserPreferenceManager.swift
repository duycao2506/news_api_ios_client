//
//  UserPreferenceManager.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation

class UserPreferenceManager : NSObject {
    static let shared : UserPreferenceManager = .init()
    
    var user : User? = nil
    
    private override init() {
        
    }
    
    func registerUser(user : User){
        UserDefaults.standard.setValue(user, forKey: user.username)
        self.user = user
    }
    
    func login(username : String, password : String) -> User? {
        guard let userRaw = UserDefaults.standard.value(forKey: username) as? User, userRaw.password == password else {
            return nil
        }
        self.user = userRaw
        return self.user
    }
}
