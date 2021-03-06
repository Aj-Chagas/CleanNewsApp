//
//  News.swift
//  Domain
//
//  Created by Anderson Chagas on 15/04/21.
//

import Foundation

public struct News: Model {
    public let status: String?
    public let totalResults: Int?
    public let articles: [Article]?
    
    public init(status: String,
                totalResults: Int,
                articles: [Article]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

public struct Article: Model {
    public let source: Source?
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
    
    public init(source: Source,
                author: String,
                title: String,
                description: String,
                url: String,
                urlToImage: String,
                publishedAt: String,
                content: String) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

public struct Source: Model {
    public let id: String?
    public let name: String?
    
    public init(id: String?,
                name: String) {
        self.id = id
        self.name = name
    }
}
