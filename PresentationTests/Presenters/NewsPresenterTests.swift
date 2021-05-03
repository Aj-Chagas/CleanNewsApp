//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 03/05/21.
//

import XCTest
import Presentation
import Domain
import Data

class NewsPresenterTests: XCTestCase {

    func test_fetchNews_should_show_loading_when_call_webService() {
        let loadingView = LoadingViewSpy()
        let sut = makeSut(loadingView: loadingView)
        
        let exp = expectation(description: "Waiting")
        loadingView.observer { viewModel in
            XCTAssertTrue(viewModel.isLoading)
            exp.fulfill()
        }
        sut.fetchNews()
        wait(for: [exp], timeout: 1)
    }
    
    func test_fetchNews_should_not_show_loading_after_received_callback_webService() {
        let loadingView = LoadingViewSpy()
        let fetchHealineNewsSpy = FetchTopHeadlineNewsSpy()
        let sut = makeSut(loadingView: loadingView, fetchTopHealineNews:  fetchHealineNewsSpy)
        sut.fetchNews()

        let exp = expectation(description: "waiting...")
        loadingView.observer { viewModel in
            XCTAssertFalse(viewModel.isLoading)
            exp.fulfill()
        }
        fetchHealineNewsSpy.completionWithNews(news: makeNews())
        wait(for: [exp], timeout: 1)
    }

}

extension NewsPresenterTests {
    
    func makeSut(loadingView: LoadingViewSpy = LoadingViewSpy(),
                 fetchTopHealineNews: FetchTopHeadlineNewsSpy = FetchTopHeadlineNewsSpy(),
                 delegate: NewsDelegateSpy = NewsDelegateSpy()) -> NewsPresenter {
        let sut = NewsPresenter(loadingView: loadingView,
                      fetchTopHealineNews: fetchTopHealineNews,
                      delegate: delegate)
        checkMemoryLeak(for: sut)
        return sut
    }
    
    class NewsDelegateSpy: NewsDelegate {
        
        var news: News?
        
        func didFetch(news: News?) {
            self.news = news
        }
        
    }
    
}
