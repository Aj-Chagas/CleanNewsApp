//
//  HttpGetClient.swift
//  Data
//
//  Created by Anderson Chagas on 15/04/21.
//

import Foundation

public protocol HttpGetClient {
    func get(to url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
