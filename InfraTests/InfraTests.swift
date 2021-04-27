//
//  InfraTests.swift
//  InfraTests
//
//  Created by Anderson Chagas on 26/04/21.
//

import XCTest
import Data

class URLSessionAdapter: HttpGetClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(to url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                return completion(.failure(.noConnectivy))
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                return completion(.failure(.serverError))
            }
            
            switch urlResponse.statusCode {
            case 200...299:
                completion(.success(data))
            case 400...499:
                completion(.failure(.badRequest))
            case 500...599:
                completion(.failure(.serverError))
            default:
                completion(.failure(.noConnectivy))
            }
        }
        task.resume()
    }
    
}

class InfraTests: XCTestCase {

    func test_get_should_make_request_with_valid_url_and_method() {
        let sut = makeSut()
        let exp = expectation(description: "Waiting")
        let url = URL(string: "http://any-url.com")!
        var request: URLRequest?
        URLProtocolStubs.observerRequest(completion: { request = $0 })
        sut.get(to: url, completion: { _ in exp.fulfill() })
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(url, request?.url)
        XCTAssertEqual("GET", request?.httpMethod)
    }
    
    func test_get_should_complete_with_error_when_received_error() {
        expectResult(.failure(.noConnectivy), when: (data: nil, response: nil, error: makeError()))
    }

}

extension InfraTests {
    func makeSut() -> URLSessionAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStubs.self]
        let session = URLSession(configuration: configuration)
        let sut = URLSessionAdapter(session: session)
        return sut
    }
    
    func expectResult(_ expectedResult: Result<Data?, HttpError>,
                      when stub: (data: Data?, response: HTTPURLResponse?, error: Error?),
                      file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        let exp = expectation(description: "Waiting")
        URLProtocolStubs.requestSimulate(data: stub.data, response: stub.response, error: stub.error)
    
        sut.get(to: makeUrl()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedSuccess), .success(let receivedSuccess)): XCTAssertEqual(expectedSuccess, receivedSuccess, file: file, line: line)
            default: XCTFail("expected \(expectedResult) got \(receivedResult) instead")
            }
            
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

    func makeError() -> NSError {
        NSError(domain: "any_error", code: 0)
    }
    
    func makeUrl() -> URL {
        URL(string: "http://any-url.com")!
    }
}

class URLProtocolStubs: URLProtocol {
    
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void){
        URLProtocolStubs.emit = completion
    }
    
    static func requestSimulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    open override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override open func startLoading() {
        URLProtocolStubs.emit?(request)
        if let data = URLProtocolStubs.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = URLProtocolStubs.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = URLProtocolStubs.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override open func stopLoading() {
    }
    
}
