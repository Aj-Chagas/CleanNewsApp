//
//  TestFactories.swift
//  DataTests
//
//  Created by Anderson Chagas on 29/04/21.
//

import Foundation
import Domain

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
