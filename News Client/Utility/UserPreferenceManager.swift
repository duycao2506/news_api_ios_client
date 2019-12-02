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
    
    func insertOrUpdate(userNew : User){
        if let user = self.user {
            UserDefaults.standard.removeObject(forKey: user.username)
        }
        UserDefaults.standard.setValue(userNew.password, forKey: userNew.username)
        self.user = userNew
    }
    
    func login(username : String, password : String) -> User? {
        guard let encodedPassword = password.data(using: .utf8)?.base64EncodedString() else {return nil}
        guard let userRaw = UserDefaults.standard.value(forKey: username) as? String, userRaw == encodedPassword else {
            return nil
        }
        do {
            let user = try User.init(username: username, password: password)
            self.user = user
        }catch _ {
            return nil
        }
        
        return self.user
    }
}
