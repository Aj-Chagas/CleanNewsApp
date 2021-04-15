//
//  GetTopHeadlinesNews.swift
//  Domain
//
//  Created by Anderson Chagas on 15/04/21.
//

import Foundation

public protocol GetTopHeadlineNews {
    func getTopHeadlineNews(completion: @escaping (Result<News, DomainError>) -> Void)
}
