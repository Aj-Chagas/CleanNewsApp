//
//  URLSessionAdapter.swift
//  Infra
//
//  Created by Anderson Chagas on 29/04/21.
//

import Foundation
import Data

public final class URLSessionAdapter: HttpGetClient {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func get(to url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void) {
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
