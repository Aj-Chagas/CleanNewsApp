//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Anderson Chagas on 29/04/21.
//

import XCTest
import Data
import Infra

class GetNewsIntegrationTests: XCTestCase {

    func test_get_top_headlines() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=288e2e5064f4453bb4686e65de93e1e3")!
        
        let urlSession = URLSessionAdapter()
        let getTopNews = RemoteGetTopNews(httpGetClient: urlSession, url: url)
        
        let exp = expectation(description: "waiting")
        getTopNews.getTopHeadlineNews { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let news):
                XCTAssertNotNil(news)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

}
