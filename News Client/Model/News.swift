//
//  News.swift
//  News Client
//
//  Created by Duy Cao on 11/30/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper

class News: NSObject,Mappable {
    var id : String = ""
    var name: String = ""
    var author : String = ""
    var newsDescription = ""
    var title : String = ""
    var url : String = ""
    var urlToImage:  String = ""
    var publishedAt : Date? = nil
    var content : String = ""
    
    required init?(map: Map) {
     
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON {
            id <- map["source.id"]
            name <- map["source.name"]
            author <- map["author"]
            title <- map["title"]
            newsDescription <- map["description"]
            url <- map["url"]
            urlToImage <- map["urlToImage"]
            publishedAt <- map["publishedAt"]
            content <- map["content"]
        }else {
            
        }
    }
    

    
}


class NewsApiData :  ApiData, Pageable, Mappable {
    
    
    var size: Int = 20
    var page: Int = 1
    var total: Int = 0
    var isEnd: Bool = false
    var data : [News] = []
    
    required init(endPoint : Endpoint = .topHeadline) {
        super.init()
        self.endPoint = endPoint
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        if map.mappingType == .fromJSON {
            total <- map["totalResults"]
            data <- map["articles"]
        }else {
            
        }
    }
    
    func reset() {
        self.page = 1
        self.isEnd = false
    }
    
    
}
