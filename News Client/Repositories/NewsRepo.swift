//
//  NewsRepo.swift
//  News Client
//
//  Created by Duy Cao on 11/30/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper


protocol NewsRepoProtocol : class {
    func getList(requestData: Pageable&ApiRequestProtocol, success: @escaping (([News])->Void), failure : @escaping ((Error)->Void))
}

class NewsRepo: NSObject, NewsRepoProtocol {
    func getList(requestData: ApiRequestProtocol & Pageable, success: @escaping (([News]) -> Void), failure: @escaping ((Error) -> Void)) {
        Alamofire.request(requestData.buildGetRequest()).responseObject { [weak requestData] (response : DataResponse<NewsApiData>) in
            if let err = response.error {
                failure(err)
                return
            }
            
            guard let responseData = response.result.value else {
                failure(ErrorHandling.getDefaultError())
                return
            }
            
            requestData?.isEnd = responseData.data.count == 0
            requestData?.total = responseData.total
            success(responseData.data)
        }
    }
    
    
}
