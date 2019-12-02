//
//  ProfileViewModel.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation

protocol ProfileViewModelProtocol : class {
    var username : Bindable<String> {get set}
    var password : Bindable<String> {get set}
    var error : Bindable<Error?> {get set}
    var isSuccessful : Bindable<Bool> {get set}
    var isLogoutSuccessful : Bindable<Bool> {get set}
    
    func saveProfile()
    func signOut()
    func loadUser()
    func validate() -> Bool
}

class ProfileViewModel : NSObject, ProfileViewModelProtocol {
    
    var isLogoutSuccessful: Bindable<Bool> = .init(false)
    
    var isSuccessful: Bindable<Bool> = .init(false)
    
    var error: Bindable<Error?> = .init(nil)
    
    var username: Bindable<String> = .init("")
    
    var password: Bindable<String> = .init("")
    
    
    override init() {
        super.init()
    }
    
    func loadUser() {
        self.username.value =  UserPreferenceManager.shared.user?.username ?? ""
        guard let dataRaw = Data.init(base64Encoded: UserPreferenceManager.shared.user?.password ?? "") else {
            return
        }
        self.password.value = String.init(data: dataRaw, encoding: .utf8) ?? ""
    }
    
    func saveProfile() {
        guard self.validate() else {return}
        do {
            let user = try User.init(username: self.username.value, password: self.password.value)
            UserPreferenceManager.shared.insertOrUpdate(userNew: user)
            self.isSuccessful.value = true
        }catch let error {
            self.error.value = error
        }
    }
    
    func signOut() {
        UserPreferenceManager.shared.user = nil
        self.isLogoutSuccessful.value = true
    }
    
    func validate () -> Bool {
        guard self.username.value.count > 0  else {
            self.error.value = NSError.init(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Empty username not allowed"])
            return false
        }
        
        guard self.password.value.count > 0 else {
            self.error.value = NSError.init(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Empty password not allowed"])
            return false
        }
        return true
    }
    
    
    
}

protocol LoginViewModelProtocol : class {
    var isRegisteredSuccessful : Bindable<Bool> {get set}
    var isSignInSuccessful : Bindable<Bool> {get set}
    
    func signIn()
    func register()
    
}

class LoginViewModel : ProfileViewModel, LoginViewModelProtocol {
    var isRegisteredSuccessful : Bindable<Bool> = .init(false)
    var isSignInSuccessful: Bindable<Bool> = .init(false)
    
    func register() {
        guard self.validate() else {return}
        do {
            let user = try User.init(username: self.username.value, password: self.password.value)
            UserPreferenceManager.shared.insertOrUpdate(userNew: user)
            self.isRegisteredSuccessful.value = true
        }catch let error {
            self.error.value = error
        }
    }
    
    func signIn() {
        guard self.validate() else {return}
        guard UserPreferenceManager.shared.login(username: self.username.value, password: self.password.value) != nil else {
            self.error.value = NSError.init(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "Wrong username/password, please try again"])
            return
        }
        self.isSignInSuccessful.value = true
    }
    
}
