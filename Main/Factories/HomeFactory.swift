//
//  HomeFactory.swift
//  Main
//
//  Created by Anderson Chagas on 10/05/21.
//

import Foundation
import UI
import Presentation
import Data
import Infra

class HomeFactory {
    static func makeViewController() -> HomeViewController {
        let controller = HomeViewController()
        let client = URLSessionAdapter()
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=288e2e5064f4453bb4686e65de93e1e3")!
        let remoteNews = RemoteFetchTopNews(httpGetClient: client, url: url)
        let presenter = NewsPresenter(loadingView: controller, fetchTopHealineNews: remoteNews, delegate: controller)
        
        controller.fetchNews = presenter.fetchNews
        
        return controller
    }
}
