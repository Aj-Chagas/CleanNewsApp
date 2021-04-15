//
//  News.swift
//  Domain
//
//  Created by Anderson Chagas on 15/04/21.
//

import Foundation

public struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

public struct Article: Codable {
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String
}

public struct Source: Codable {
    let id: String?
    let name: String
}
