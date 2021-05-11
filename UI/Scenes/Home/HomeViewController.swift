//
//  HomeViewController.swift
//  UI
//
//  Created by Anderson Chagas on 04/05/21.
//

import UIKit
import Presentation
import Domain

public final class HomeViewController: UIViewController {
    
    public var fetchNews: (() -> Void)?
    
    private var mainView = HomeView()

    override public func loadView() {
        self.view = mainView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        fetchNews?()
    }
}

extension HomeViewController: LoadingView {

    public func display(viewModel: LoadingViewModel) {
    }
    
}

extension HomeViewController: NewsDelegate {

    public func didFetch(news: News?) {
    }
    
}
