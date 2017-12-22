//
//  GradientView.swift
//  Craftsmen
//
//  Created by Macbook Air on 11/07/17.
//  Copyright © 2017 Promobi. All rights reserved.
//

import UIKit

class GradientView: UIView {

    private let gradient : CAGradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.gradient.frame = self.bounds
    }
    
    override public func draw(_ rect: CGRect) {
        self.gradient.frame = self.bounds
        self.gradient.colors = [UIColor.black.cgColor, UIColor.init(hexString: "00000005")!.cgColor]
//        self.gradient.startPoint = CGPoint.init(x: 0, y: 0)
//        self.gradient.endPoint = CGPoint.init(x: 1, y: 1)
//        if self.gradient.superlayer != nil {
            self.layer.insertSublayer(self.gradient, at: 0)
//        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
