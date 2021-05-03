//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 03/05/21.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    
    var emit: ((LoadingViewModel) -> Void)?
    
    func display(viewModel: LoadingViewModel) {
        emit?(viewModel)
    }
    
    func observer(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
}
