//
//  File.swift
//  UI
//
//  Created by Anderson Chagas on 14/05/21.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadNetworkImage(url: URL) {
        self.sd_setImage(with: url, placeholderImage: nil)
    }
}
