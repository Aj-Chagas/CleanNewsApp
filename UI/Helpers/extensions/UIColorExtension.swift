//
//  UIColorExtension.swift
//  UI
//
//  Created by Anderson Chagas on 12/05/21.
//

import UIKit
 
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    convenience init(hexdecimal: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (hexdecimal >> 16) & 0xFF,
            green: (hexdecimal >> 8) & 0xFF,
            blue: hexdecimal & 0xFF,
            alpha: alpha
        )
    }
    
    static func hex605751() -> UIColor {
        return UIColor(hexdecimal: 0x605751)
    }

}
