//
//  NewsListItemViewModel.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation
protocol NewsListItemViewModelProtocol : ListItemViewModelProtocol {
    var dateformatter : DateFormatter {get set}
    var imageUrl : String {get set}
    var title : String { get set }
    var newsDescription : String {get set}
    var author : String {get set}
    var date : String {get set}
}

class NewsListItemViewModel : NewsListItemViewModelProtocol {
    var dateformatter: DateFormatter = .init(withFormat: "dd-MM-yyyy HH:mm:ss", locale: Locale.current.identifier)
    
    var imageUrl: String = ""
    
    var title: String = ""
    
    var newsDescription: String = ""
    
    var author: String = ""
    
    var date: String = ""
    
    required init(news : News) {
        self.imageUrl = news.urlToImage
        self.title = news.title
        self.newsDescription = news.newsDescription
        self.author = news.author
        self.date = dateformatter.string(from: news.publishedAt)
    }
    
}
