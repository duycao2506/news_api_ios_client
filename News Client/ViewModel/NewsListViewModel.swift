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
    
    func loadMore() {
        
    }
    
    func reload() {
        
    }
    
    init(repo : NewsRepoProtocol = NewsRepo.init()) {
        self.repo = repo
    }
    
}
