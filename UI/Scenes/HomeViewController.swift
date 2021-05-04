//
//  HomeViewController.swift
//  UI
//
//  Created by Anderson Chagas on 04/05/21.
//

import UIKit
import Presentation
import Domain

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
