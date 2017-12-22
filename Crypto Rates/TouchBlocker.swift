//
//  TouchBlocker.swift
//  EasySurvey
//
//  Created by Macbook Air on 31/05/16.
//  Copyright © 2016 SrB. All rights reserved.
//

import UIKit

class TouchBlocker: UIView {

    var blackView: UIView!
    var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        let blackView = UIView()
        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        blackView.layer.cornerRadius = 10
        self.blackView = blackView
        self.addSubview(blackView)
        
        self.addConstraint(NSLayoutConstraint(item: blackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: blackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: blackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
        self.addConstraint(NSLayoutConstraint(item: blackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        self.activityIndicator = activityIndicator
        blackView.addSubview(activityIndicator)
        
        blackView.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: blackView, attribute: .centerX, multiplier: 1, constant: 0))
        blackView.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: blackView, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading() -> Void {
        DispatchQueue.main.async {
            self.isHidden = false
            self.activityIndicator.startAnimating()
            self.superview?.bringSubview(toFront: self)
        }
    }
    
    func hideLoading() -> Void {
        DispatchQueue.main.async {
//        UIView.animate(withDuration: 0.00, delay: 0.0, options: .curveEaseOut, animations: {
                self.activityIndicator.stopAnimating()
                self.isHidden = true
    //            }, completion: { finished in
    //        })
        }
    }

}
