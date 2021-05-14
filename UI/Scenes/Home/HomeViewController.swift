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
    
    private var news: [Article]?

    override public func loadView() {
        self.view = mainView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchNews?()
    }
    
    func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardViewCell.kIdentifier, for: indexPath) as? CardViewCell else {
            return UITableViewCell()
        }
        cell.title.text = news?[indexPath.row].title
        cell.subTitle.text = news?[indexPath.row].description
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}
