//
//  UITests.swift
//  UITests
//
//  Created by Anderson Chagas on 04/05/21.
//

import XCTest
import Presentation
import Domain
import Data
import Infra
import UIKit

class HomeViewController: UIViewController {
    
    var fetchNews: (() -> Void)?

    override func loadView() {
        super.loadView()
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .darkGray
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews?()
    }
}

extension HomeViewController: LoadingView {

    func display(viewModel: LoadingViewModel) {
    }
    
}

extension HomeViewController: NewsDelegate {

    func didFetch(news: News?) {
    }
    
}

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
