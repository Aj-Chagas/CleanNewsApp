//
//  HomeView.swift
//  UI
//
//  Created by Anderson Chagas on 10/05/21.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Notícias"
        view.font = UIFont.boldSystemFont(ofSize: 32)
        return view
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
        addSubview(title)
    }
    
    func setupConstraint() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
    
}
