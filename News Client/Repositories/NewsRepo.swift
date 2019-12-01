//
//  NewsRepo.swift
//  News Client
//
//  Created by Duy Cao on 11/30/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

protocol NewsRepoProtocol : class {
    func getList(success: @escaping (([News])->Void), failure : ((NSError)->Void))
}

class NewsRepo: NSObject, NewsRepoProtocol {
    func getList(success: @escaping (([News])->Void), failure : ((NSError)->Void)) {
        
    }
}
