//
//  HomeViewDataSource.swift
//  UI
//
//  Created by Anderson Chagas on 14/05/21.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardViewCell.kIdentifier, for: indexPath) as? CardViewCell else {
            return UITableViewCell()
        }
        
        if let safeStringUrl = news?[indexPath.row].urlToImage,
           let safeUrl = URL(string: safeStringUrl) {
            cell.imageV.loadNetworkImage(url: safeUrl)
        } else {
            //image default
        }
        
        cell.title.text = news?[indexPath.row].title
        cell.subTitle.text = news?[indexPath.row].description
        
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}
