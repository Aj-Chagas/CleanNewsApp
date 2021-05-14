//
//  UIViewExtension.swift
//  UI
//
//  Created by Anderson Chagas on 12/05/21.
//

import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let cornerRadii = CGSize(
            width: radius,
            height: radius
        )
        
        let maskPath = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.frame = self.bounds

        self.layer.mask = maskLayer
    }
    
    func safeArea() -> CGFloat {
        self.safeAreaLayoutGuide.layoutFrame.size.height
    }
    
}

extension UIImageView {

}
