//
//  ProjectSetting.swift
//  News Client
//
//  Created by Duy Cao on 12/1/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class ProjectSetting: NSObject {
    static let shared : ProjectSetting = .init()
    enum EnumSetting : String {
        case apiUrl = "API_BASE_URL"
        case apiKey = "API_SECRET_KEY"
    }
    
    private override init () {
        
    }
    
    static func getSetting(name : EnumSetting) -> Any? {
        return (Bundle.main.object(forInfoDictionaryKey: "APIBundle") as? Dictionary)?[name.rawValue]
    }
    
    let apiUrl : String = {
        guard let value = getSetting(name: .apiUrl) as? String else {
            assertionFailure("Didn't set base url")
            return ""
        }
        return value
    }()
    
    let apiKey : String = {
        guard let value = getSetting(name: .apiKey) as? String else {
            assertionFailure("Didn't set api key")
            return ""
        }
        return value
    }()
    
    
}
