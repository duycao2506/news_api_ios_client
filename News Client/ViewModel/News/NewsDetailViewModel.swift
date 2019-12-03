//
//  NewsDetailViewModel.swift
//  News Client
//
//  Created by Duy Cao on 12/3/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation

protocol NewsDetailViewModelProtocol {
    var content : String {get set}
    var urlToSource : String {get set}
}

class NewsDetailViewModel : NewsListItemViewModel, NewsDetailViewModelProtocol {
    var content: String = ""
    
    var urlToSource: String = ""
    
    required init(news: News) {
        super.init(news: news)
        self.content = news.content
        self.urlToSource = news.url
    }
}
