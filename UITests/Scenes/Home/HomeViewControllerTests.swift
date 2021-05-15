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
    
    func test_numberOfRowsInSection_should_return_zero_when_list_is_nil() {
        let sut = makeSut()
        let tableView = sut.mainView.tableView
        let expectedResult = 0
        XCTAssertEqual(expectedResult, tableView.numberOfRows(inSection: 0))
    }
    
    func test_viewForHeaderInSection_should_return_HeaderView_instance() {
        let sut = makeSut()
        let tableView = sut.mainView.tableView
        let expectedView = tableView.delegate?.tableView?(tableView, viewForHeaderInSection: 1)
        XCTAssertNotNil(expectedView as! HeaderView)
    }
    
    func test_numberOfSections_should_return_1() {
        let sut = makeSut()
        let tableView = sut.mainView.tableView
        let expectedResult = 1
        XCTAssertEqual(expectedResult, tableView.numberOfSections)
    }
    
    func test_cellForRowAt_should_return_cardViewCell() {
        let sut = makeSut()
        let tableView = sut.mainView.tableView
        let news = makeNews()
        sut.news = news.articles
        let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell as! CardViewCell)
    }
    
    func test_bindCardViewCell_should_bind_view_correct() {
        let sut = makeSut()
        let tableView = sut.mainView.tableView
        let news = makeNews()
        sut.news = news.articles
        sut.loadViewIfNeeded()
        let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! CardViewCell
        XCTAssertEqual(cell.title.text, "any_title")
        XCTAssertEqual(cell.subTitle.text, "any_description")
    }

}

extension HomeViewControllerTests {
    
    func makeSut(fetchNews: (() -> Void)? = nil) -> HomeViewController {
        let controller = HomeViewController(mainView: HomeView())
        controller.fetchNews = fetchNews
        controller.loadViewIfNeeded()
        checkMemoryLeak(for: controller)
        return controller
    }
}
