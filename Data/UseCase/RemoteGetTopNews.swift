//
//  RemoteGetTopNews.swift
//  Data
//
//  Created by Anderson Chagas on 15/04/21.
//

import Foundation
import Domain

public final class RemoteGetTopNews: GetTopHeadlineNews {
    
    private let httpGetClient: HttpGetClient
    private let url: URL
    
    public init(httpGetClient: HttpGetClient, url: URL) {
        self.httpGetClient = httpGetClient
        self.url = url
    }

    public func getTopHeadlineNews(completion: @escaping (Result<News, DomainError>) -> Void) {
        httpGetClient.get(to: url, with: nil) { [weak self] result in
             guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: News = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.failWrapJson))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
    
}
