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
        sut.getTopHeadlineNews { _ in }
        XCTAssertEqual(httpCLient.url, url)
    }

    func test_getTopHeadlineNews_should_completes_with_error_if_client_complete_with_error() {
        let url = URL(string: "any_url.com")!
        let (sut, httpCLient) = makeSut(url: url)
        let exp = expectation(description: "waiting")
        sut.getTopHeadlineNews { result in
            switch result {
            case .success: XCTFail("Expected failure and received success instead")
            case .failure(let error): XCTAssertEqual(error, DomainError.unexpected)
            }
            exp.fulfill()
        }
        httpCLient.completionWithError()
        wait(for: [exp], timeout: 1)
    }

    func test_getTopHeadlineNews_should_completes_with_error_if_client_complete_with_invalid_data() {
        let url = URL(string: "any_url.com")!
        let (sut, httpCLient) = makeSut(url: url)
        let exp = expectation(description: "waiting")
        sut.getTopHeadlineNews { result in
            switch result {
            case .success: XCTFail("Expected failure and received success instead")
            case .failure(let error): XCTAssertEqual(error, DomainError.failWrapJson)
            }
            exp.fulfill()
        }
        httpCLient.completionWithInvalidData()
        wait(for: [exp], timeout: 1)
    }
    
    func test_getTopHeadlineNews_should_completes_with_success_if_client_complete_with_valid_data() {
        let url = URL(string: "any_url.com")!
        let (sut, httpCLient) = makeSut(url: url)
        let expectedData: Data = makeNews().toData()!
        let exp = expectation(description: "waiting")
        sut.getTopHeadlineNews { result in
            switch result {
            case .success(let data): XCTAssertEqual(expectedData.toModel(), data)
            case .failure: XCTFail("Expected success and received error instead")
            }
            exp.fulfill()
        }
        httpCLient.completionWithSuccess(with: expectedData)
        wait(for: [exp], timeout: 1)
    }

    func test_add_should_not_complete_if_sut_has_been_deallocated() {
        let url = URL(string: "any_url.com")!
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteGetTopNews? = RemoteGetTopNews(httpGetClient: httpClientSpy, url: url)
        var result: Result<News, DomainError>?
        sut?.getTopHeadlineNews { result = $0 }
        sut = nil
        httpClientSpy.completionWithError()
        XCTAssertNil(result)
    }
}


extension RemoteGetTopNewsTests {
    
    func makeSut(url: URL = URL(string: "any_url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (RemoteGetTopNews, HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteGetTopNews(httpGetClient: httpClientSpy, url: url)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy)
        return (sut, httpClientSpy)
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
                        publishedAt: Date(),
                        content: "any_content")])
    }
    
}

