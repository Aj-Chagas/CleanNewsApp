//
//  UITests.swift
//  UITests
//
//  Created by Anderson Chagas on 04/05/21.
//

import XCTest
import UIKit
import Presentation
import Domain
@testable import UI

class HomeViewControllerTests: XCTestCase {

    func test_sut_implements_loadingView_protocol() {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_news_delegate() {
        let sut = makeSut()
        XCTAssertNotNil(sut as NewsDelegate)
    }

}

extension HomeViewControllerTests {
    
    func makeSut(fetchNews: (() -> Void)? = nil) -> HomeViewController {
        let controller = HomeViewController()
        controller.fetchNews = fetchNews
        controller.loadViewIfNeeded()
        return controller
    }
}
