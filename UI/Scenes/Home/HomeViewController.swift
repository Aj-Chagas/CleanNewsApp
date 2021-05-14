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
    
    internal var news: [Article]?

    override public func loadView() {
        self.view = mainView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchNews?()
    }
    
    private func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.tableHeaderView = HeaderView()
    }
}

extension HomeViewController: LoadingView {

    public func display(viewModel: LoadingViewModel) {
    }
    
}

extension HomeViewController: NewsDelegate {

    public func didFetch(news: News?) {
        guard let safeNews = news else  {
            print("deu ruim")
            return
        }
        self.news = safeNews.articles
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
    
}
