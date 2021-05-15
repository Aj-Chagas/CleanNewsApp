//
//  HomeView.swift
//  UI
//
//  Created by Anderson Chagas on 10/05/21.
//

import UIKit
import SnapKit

public final class HomeView: UIView {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.rowHeight = CGFloat(400)
        table.isScrollEnabled = true
        table.backgroundColor = .white
        table.allowsSelection = false
        table.separatorStyle = .none
        table.register(CardViewCell.self, forCellReuseIdentifier: CardViewCell.kIdentifier)
        return table
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView: CodeView {

    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraint() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.safeArea().top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
    
}
