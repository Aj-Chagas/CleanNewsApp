//
//  FetchTopHealineNewsSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 03/05/21.
//

import Foundation
import Domain

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
