//
//  CardView.swift
//  UI
//
//  Created by Anderson Chagas on 12/05/21.
//

import UIKit
import SnapKit

// try transformation this class in UIVIEW
class CardView: UITableViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .green
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(red: 0.902, green: 0.902, blue: 0.906, alpha: 1)
        return view
    }()
    
    lazy var imageV: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "News"
        view.font = UIFont.boldSystemFont(ofSize: 24)
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 2
        return view
    }()
    
    lazy var subTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "subtitle"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 2
        return view
    }()
    
    static let kIdentifier = "CardViewId"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageV.roundCorners([.topLeft, .topRight], radius: 8)
    }
}

extension CardView: CodeView {
    
    func buildViewHierarchy() {
        addSubview(containerView)
        addSubview(imageV)
        addSubview(title)
        addSubview(subTitle)
    }
    
    func setupConstraint() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        imageV.snp.makeConstraints { make in
            make.top.equalTo(containerView)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
        }

        title.snp.makeConstraints { make in
            make.top.equalTo(imageV.snp.bottom).offset(8)
            make.left.equalTo(imageV).offset(8)
            make.right.equalTo(imageV).inset(8)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.left.equalTo(title)
            make.right.equalTo(title)
            make.bottom.equalTo(containerView).inset(16)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
    
}

