//
//  News.swift
//  Domain
//
//  Created by Anderson Chagas on 15/04/21.
//

import Foundation

public struct News: Model {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
    public init(status: String,
                totalResults: Int,
                articles: [Article]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

public struct Article: Model {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
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
    let id: String?
    let name: String?
    
    public init(id: String?,
                name: String) {
        self.id = id
        self.name = name
    }
}
