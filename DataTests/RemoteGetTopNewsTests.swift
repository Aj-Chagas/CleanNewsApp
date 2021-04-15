//
//  DataTests.swift
//  DataTests
//
//  Created by Anderson Chagas on 15/04/21.
//

import XCTest
import Domain

public protocol HttpGetClient {
    func get(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}

public enum HttpError: Error {
    case noConnectivy
    case badRequest
    case serverError
    case unauthorized
    case forbideen
}

public final class RemoteGetTopNews: GetTopHeadlineNews {
    
    private let httpGetClient: HttpGetClient
    private let url: URL
    
    public init(httpGetClient: HttpGetClient, url: URL) {
        self.httpGetClient = httpGetClient
        self.url = url
    }

    public func getTopHeadlineNews(completion: @escaping (Result<News, DomainError>) -> Void) {
        httpGetClient.get(to: url, with: nil) { result in
        }
    }
    
}

class RemoteGetTopNewsTests: XCTestCase {

    func test_getTopHeadlineNews_should_call_httpClient_with_correct_url() {
        let url = URL(string: "any_url.com")!
        let (sut, httpCLient) = makeSut(url: url)
        sut.getTopHeadlineNews { _ in }
        XCTAssertEqual(httpCLient.url, url)
    }
}


extension RemoteGetTopNewsTests {
    
    func makeSut(url: URL = URL(string: "any_url.com")!) -> (RemoteGetTopNews, HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        return (RemoteGetTopNews(httpGetClient: httpClientSpy, url: url), httpClientSpy)
    }
    
    class HttpClientSpy: HttpGetClient {
        var url: URL?
        var data: Data?
        var completion: ((Result<Data?, HttpError>) -> Void)?
        
        func get(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
            self.url = url
            self.data = data
            self.completion = completion
        }
    }
}
