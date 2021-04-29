//
//  TestFactories.swift
//  DataTests
//
//  Created by Anderson Chagas on 29/04/21.
//

import Foundation

func makeValidData() -> Data {
    Data("{\"name\": \"Anderson\"}".utf8)
}

func makeError() -> NSError {
    NSError(domain: "any_error", code: 0)
}

func makeUrl() -> URL {
    URL(string: "http://any-url.com")!
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
