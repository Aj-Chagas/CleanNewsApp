//
//  NewsPresenter.swift
//  Presentation
//
//  Created by Anderson Chagas on 03/05/21.
//

import Foundation
import Domain

public protocol NewsDelegate {
    func didFetch(news: News?)
}

public final class NewsPresenter {
    
    private let loadingView: LoadingView
    private let fetchTopHealineNews: FetchTopHeadlineNews
    private let delegate: NewsDelegate
    
    public init(loadingView: LoadingView,
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
