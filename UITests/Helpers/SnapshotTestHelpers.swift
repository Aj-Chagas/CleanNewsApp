//
//  BaseQuickSpec.swift
//  UITests
//
//  Created by Anderson Chagas on 13/05/21.
//

import UIKit

var allIphoneDimensions = ["iphone8": CGSize(width: 375, height: 667),
                           "iphone11Pro": CGSize(width: 375, height: 812),
                           "iphoneSE": CGSize(width: 320, height: 568)]


func iphone8Frame() -> CGRect {
    return CGRect(x: 0, y: 0, width: 375, height: 667)
}
