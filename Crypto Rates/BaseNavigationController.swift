//
//  BaseNavigationController.swift
//  Craftsmen
//
//  Created by Macbook Air on 27/06/17.
//  Copyright © 2017 Promobi. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK:- helpers
    func setupBackButton() {
        //left bar button
        let blueColor = UIColor.init(red: 0, green: 0.48, blue: 1, alpha: 1)
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        backButton.addTarget(self, action: #selector(back) , for: .touchUpInside)
        backButton.setTitle(AppManager.ESLocalized(key: "Back"), for: .normal)
        backButton.setTitleColor(blueColor, for: .normal)
        
        let image = #imageLiteral(resourceName: "back_arrow_white").withRenderingMode(.alwaysTemplate)
        backButton.imageView?.tintColor = blueColor
        backButton.setImage(image , for: .normal)
        
        let backBarItem = UIBarButtonItem(customView: backButton)
//        self.navigationItem.leftBarButtonItem = backBarItem
        self.navigationItem.backBarButtonItem = backBarItem
    }
    
    
    //MARK:- callbacks
    @objc func back() {
        DispatchQueue.main.async {
            self.popViewController(animated: true)
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        let item = UIBarButtonItem(title: AppManager.ESLocalized(key: "Back"), style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
