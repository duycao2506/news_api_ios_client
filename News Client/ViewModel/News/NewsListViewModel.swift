//
//  NewsListViewModel.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import Foundation

protocol NewsListViewModelProtocol : ListViewModelProtocol {
    
}

class NewsListViewModel : NewsListViewModelProtocol {
    var loading: Bindable<Bool> = .init(false)
    
    var error: Bindable<Error?> = .init(nil)
    
    var itemList: Bindable<[ListItemViewModelProtocol]> = .init([])
    
    var apiData: ApiData = .init()
    
    
    var repo : NewsRepoProtocol!
    
    private func load(willShowLoad : Bool = true){
        if willShowLoad {self.loading.value = true}
        self.repo.getList(requestData: apiData, success: {[weak self] (newsList) in
            guard let self = self else {return}
            var tmpList : [ListItemViewModelProtocol] = newsList.map({NewsListItemViewModel.init(news: $0)})
            if self.apiData.page > 1 {
                tmpList = self.itemList.value + tmpList
            }
            self.itemList.value = tmpList
            if willShowLoad {self.loading.value = false}
        }) { [weak self] (error) in
            if willShowLoad {self?.loading.value = false}
            self?.error.value = error
        }
    }
    
    func itemAt(index: Int) -> ListItemViewModelProtocol {
        return self.itemList.value[index]
    }
    
    func loadMore() {
        self.apiData.page += 1
        self.load(willShowLoad: false)
    }
    
    func reload() {
        self.apiData.page = 1
        self.load()
    }
    
    init(repo : NewsRepoProtocol = NewsRepo.init()) {
        self.repo = repo
        let newsApidata = NewsApiData.init()
        self.apiData = newsApidata
        
    }
    
    func itemCount() -> Int {
        return self.itemList.value.count
    }
    
}

class HeadlinesNewsListViewModel : NewsListViewModel {
    override init(repo: NewsRepoProtocol = NewsRepo.init()) {
        super.init(repo: repo)
        self.apiData.endPoint = .topHeadline
    }
}

protocol CustomNewsListViewModelProtocol : class {
    var newsQuery : Bindable<Query> {get set}
    
    func updateNewsQuery (query : Query)
}

class CustomNewsListViewModel : NewsListViewModel, CustomNewsListViewModelProtocol {
    var newsQuery : Bindable<Query> = .init(.newsBitcoin)
    
    override init(repo: NewsRepoProtocol = NewsRepo.init()) {
        super.init(repo: repo)
        self.apiData.query = newsQuery.value
    }
    
    func updateNewsQuery(query: Query) {
        self.apiData.query = query
        self.newsQuery.value = query
    }
    
}
