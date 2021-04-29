//
//  URLProtocolStubs.swift
//  InfraTests
//
//  Created by Anderson Chagas on 29/04/21.
//

import Foundation

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
