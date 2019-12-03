//
//  RequestService.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit
import Alamofire

enum Language : String {
    case english = "en"
}

enum Query : String, CaseIterable {
    case newsBitcoin = "bitcoin"
    case newsApple = "apple"
    case newsEarthquake = "earthquake"
    case newsAnimal = "animal"
}

enum Endpoint : String {
    case topHeadline = "top-headlines"
    case everything = "everything"
}

protocol Pageable : class {
    var size : Int {get set}
    var page : Int {get set}
    var total : Int {get set}
    var isEnd : Bool {get set}
    
    func reset() -> Void
}

protocol ApiRequestProtocol : class {
    var query: Query? {get set}
    var lang : Language {get set}
    var endPoint : Endpoint {get set}
    
    func buildGetRequest() -> String
}

class ApiData : NSObject, ApiRequestProtocol, Pageable {
    var size: Int = 0
    
    var page: Int = 1
    
    var total: Int = 0
    
    var isEnd: Bool = false
    
    var query: Query? = nil
    
    var lang: Language = .english
    
    var endPoint: Endpoint = .topHeadline
    
    func buildGetRequest() -> String {
         return RequestBuilder
            .init(endPoint: self.endPoint)
            .withQuery(query: query)
            .withLanguage(lang: lang)
            .withPage(page: self.page)
            .build()
        
    }
    
    func reset() {
        isEnd = false
        page = 1
    }
    

}

class ErrorHandling {
    static func getDefaultError() -> Error {
        return NSError.init(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "Unknown Error"])
    }
}

class RequestBuilder : NSObject {
    private var url : String = ""
    
    init(endPoint : Endpoint) {
        self.url.append(ProjectSetting.shared.apiUrl)
        self.url.append("\(endPoint.rawValue)?")
        self.url.append("apiKey=\(ProjectSetting.shared.apiKey)")
    }
    
    func withLanguage(lang : Language) -> RequestBuilder {
        self.url.append("&language=\(lang.rawValue)")
        return self
    }
    
    func withPage (page : Int) ->RequestBuilder {
        self.url.append("&page=\(page)")
        return self
    }
    
    func withQuery(query : Query?) -> RequestBuilder {
        guard let query = query else {return self}
        self.url.append("&q=\(query.rawValue)")
        return self
    }
    
    func build() -> String {
        return self.url.trimmingCharacters(in: [" "])
    }
    
}
