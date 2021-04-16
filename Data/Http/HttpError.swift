//
//  HttpError.swift
//  Data
//
//  Created by Anderson Chagas on 15/04/21.
//

import Foundation

public enum HttpError: Error {
    case noConnectivy
    case badRequest
    case serverError
    case unauthorized
    case forbideen
}
