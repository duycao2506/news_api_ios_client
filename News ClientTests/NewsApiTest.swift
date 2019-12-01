//
//  NewsApiTest.swift
//  News ClientTests
//
//  Created by Duy Cao on 12/2/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import XCTest
@testable import News_Client

class NewsApiTest: XCTestCase {
    
    var repo : NewsRepo!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //given
        repo = NewsRepo.init()
    }

    func testGet(){
        //when
        var newsApiData = NewsApiData.init(endPoint: .topHeadline)
        
        //then
        getWithNewsApiData(newsApiData: newsApiData)
        
        //when
        newsApiData = NewsApiData.init(endPoint: .everything)
        
        //then
        getWithNewsApiData(newsApiData: newsApiData)
    }
    
    func getWithNewsApiData(newsApiData : NewsApiData){
        let expect = expectation(description: "apinews")
        repo.getList(requestData: newsApiData, success: { (arr) in
            print(arr)
            expect.fulfill()
            XCTAssert(arr.count > 0)
        }) { (error) in
            expect.fulfill()
            XCTAssert(error == nil)
        }
        wait(for: [expect], timeout: 2)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
