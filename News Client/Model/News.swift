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
    var publishedAt : Date = Date()
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
            publishedAt <- (map["publishedAt"],DateFormatTransform.init(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'"))
            content <- map["content"]
        }else {
            
        }
    }
    

    
}


class NewsApiData :  ApiData, Mappable {
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
    
    
}
