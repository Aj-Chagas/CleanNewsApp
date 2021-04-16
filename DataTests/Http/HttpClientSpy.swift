//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Anderson Chagas on 15/04/21.
//

import Foundation
import Data

class HttpClientSpy: HttpGetClient {
    var url: URL?
    var data: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func get(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.url = url
        self.data = data
        self.completion = completion
    }
    
    func completionWithError() {
        completion?(.failure(.unauthorized))
    }
    
    func completionWithInvalidData() {
        completion?(.success(Data("invalid_data".utf8)))
    }
    
    func completionWithSuccess(with data: Data?) {
        completion?(.success(data!))
    }
}
