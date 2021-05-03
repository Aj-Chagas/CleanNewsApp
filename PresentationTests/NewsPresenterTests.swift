//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 03/05/21.
//

import XCTest
import Domain
import Data

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    public let isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}

public protocol NewsDelegate {
    func didFetch(news: News?)
}

public final class NewsPresenter {
    
    private let loadingView: LoadingView
    private let fetchTopHealineNews: FetchTopHeadlineNews
    private let delegate: NewsDelegate
    
    init(loadingView: LoadingView,
         fetchTopHealineNews: FetchTopHeadlineNews,
         delegate: NewsDelegate) {
        self.loadingView = loadingView
        self.fetchTopHealineNews = fetchTopHealineNews
        self.delegate = delegate
    }
    
    public func fetchNews() {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        fetchTopHealineNews.fetchTopHeadlineNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news): self.delegate.didFetch(news: news)
            case .failure: self.delegate.didFetch(news: nil)
            }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
        }
    }
    
}

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
    
    class LoadingViewSpy: LoadingView {
        
        var emit: ((LoadingViewModel) -> Void)?
        
        func display(viewModel: LoadingViewModel) {
            emit?(viewModel)
        }
        
        func observer(completion: @escaping (LoadingViewModel) -> Void) {
            self.emit = completion
        }
    }
    
    class FetchTopHeadlineNewsSpy: FetchTopHeadlineNews {
        
        var completion: ((Result<News, DomainError>) -> Void)?

        func fetchTopHeadlineNews(completion: @escaping (Result<News, DomainError>) -> Void) {
            self.completion = completion
        }
        
        func completionWithError() {
            completion?(.failure(.unexpected))
        }
        
        func completionWithNews(news: News) {
            completion?(.success(news))
        }
        
    }
}
