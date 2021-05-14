//
//  HeaderView.swift
//  UI
//
//  Created by Anderson Chagas on 14/05/21.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    var dateLabel: UILabel = {
        let view = UILabel()
        view.text = "sexta-feira, 14 de maio"
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    var title: UILabel = {
        let view = UILabel()
        view.text = "Hoje"
        view.font = UIFont.boldSystemFont(ofSize: 24)
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

extension HeaderView: CodeView {
    
    func buildViewHierarchy() {
        addSubview(dateLabel)
        addSubview(title)
    }
    
    func setupConstraint() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.left.equalTo(dateLabel.snp.left)
            make.right.equalTo(dateLabel.snp.right)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
    
}

