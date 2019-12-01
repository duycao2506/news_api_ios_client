//
//  ListViewModel.swift
//  News Client
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

protocol ListViewModelProtocol {
    var itemList : Bindable<[ListItemViewModelProtocol]> {get set}
    var apiData : ApiData {get set}
    var loading : Bindable<Bool> {get set}
    var error : Bindable<Error?> {get set}
    
    func loadMore()
    func reload()
}

protocol ListItemViewModelProtocol : class {}

