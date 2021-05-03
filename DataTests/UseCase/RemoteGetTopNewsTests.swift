//
//  DataTests.swift
//  DataTests
//
//  Created by Anderson Chagas on 15/04/21.
//

import XCTest
import Data
import Domain

class RemoteGetTopNewsTests: XCTestCase {

    func test_getTopHeadlineNews_should_call_httpClient_with_correct_url() {
        let url = URL(string: "any_url.com")!
        let (sut, httpCLient) = makeSut(url: url)
        sut.fetchTopHeadlineNews { _ in }
        XCTAssertEqual(httpCLient.url, url)
    }

    func test_getTopHeadlineNews_should_completes_with_error_if_client_complete_with_error() {
        let (sut, httpCLient) = makeSut()
        expect(sut: sut, expectResult: .failure(.unexpected), when: {
            httpCLient.completionWithError()
        })
    }

    func test_getTopHeadlineNews_should_completes_with_error_if_client_complete_with_invalid_data() {
        let (sut, httpCLient) = makeSut()
        expect(sut: sut, expectResult: .failure(.failWrapJson), when: {
            httpCLient.completionWithInvalidData()
        })
    }
    
    func test_getTopHeadlineNews_should_completes_with_success_if_client_complete_with_valid_data() {
        let url = URL(string: "any_url.com")!
        let (sut, httpCLient) = makeSut(url: url)
        let expectedResult: News = makeNews()
        expect(sut: sut, expectResult: .success(expectedResult), when: {
            httpCLient.completionWithSuccess(with: expectedResult.toData()!)
        })
    }

    func test_add_should_not_complete_if_sut_has_been_deallocated() {
        let url = URL(string: "any_url.com")!
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteFetchTopNews? = RemoteFetchTopNews(httpGetClient: httpClientSpy, url: url)
        var result: Result<News, DomainError>?
        sut?.fetchTopHeadlineNews { result = $0 }
        sut = nil
        httpClientSpy.completionWithError()
        XCTAssertNil(result)
    }
}


extension RemoteGetTopNewsTests {
    
    func makeSut(url: URL = URL(string: "any_url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (RemoteFetchTopNews, HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteFetchTopNews(httpGetClient: httpClientSpy, url: url)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func expect(sut: RemoteFetchTopNews, expectResult: Result<News, DomainError>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.fetchTopHeadlineNews { receivedResult in
            switch (receivedResult, expectResult) {
            case (.failure(let receivedError), .failure(let expectedError)): XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            case (.success(let receivedNews), .success(let expectedNews)): XCTAssertEqual(receivedNews, expectedNews, file: file, line: line)
            default: XCTFail("Expected \(expectResult) received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
    func makeNews() -> News {
        News(status: "any_status",
             totalResults: 1,
             articles: [
                Article(source: Source(id: nil, name: "any_name"),
                        author: "any_author",
                        title: "any_title",
                        description: "any_description",
                        url: "any_url",
                        urlToImage: "any_url_image",
                        publishedAt: "any_date",
                        content: "any_content")])
    }
    
}

