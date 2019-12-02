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
}

class ProfileViewModel : ProfileViewModelProtocol {
    var isSuccessful: Bindable<Bool> = .init(false)
    
    var error: Bindable<Error?> = .init(nil)
    
    var username: Bindable<String> = .init("")
    
    var password: Bindable<String> = .init("")
    
    init() {
        
    }
}
