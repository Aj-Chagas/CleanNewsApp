//
//  CodeVIEW.swift
//  UI
//
//  Created by Anderson Chagas on 11/05/21.
//

import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraint()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraint()
        setupAdditionalConfiguration()
    }
}
