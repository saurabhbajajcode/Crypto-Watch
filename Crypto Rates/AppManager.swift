
//
//  AppManager.swift
//  Craftsmen
//
//  Created by Macbook Air on 06/06/17.
//  Copyright © 2017 Promobi. All rights reserved.
//

import Foundation
import UIKit
//import CoreData
//import GTToast
//import SwiftMessages
//import SDWebImage

class AppManager: NSObject {
    
    static var touchBlocker: TouchBlocker?
    
    class func showConfirmActionAlert(title: String, message: String, completionHandler: @escaping ((Bool) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //add CANCEL button on alert dialog
        alert.addAction(UIAlertAction(title: AppManager.ESLocalized(key: "Cancel"), style: .cancel, handler: { (_) in
            completionHandler(false)
        }))
        
        //add OK button on alert dialog
        alert.addAction(UIAlertAction(title: AppManager.ESLocalized(key: "Yes"), style: .default, handler: { _ in
            completionHandler(true)
        }))
        DispatchQueue.main.async {
            if var topViewController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topViewController.presentedViewController {
                    topViewController = presentedViewController
                }
                if let navigationController = (topViewController as? UINavigationController) {
                    topViewController = navigationController.visibleViewController!
                }
                if let tabBarController = topViewController as? UITabBarController {
                    topViewController = tabBarController.selectedViewController!
                }
                
                // topViewController should now be your currently visible controller
                topViewController.present(alert, animated: false, completion: nil)
            }
        }
    }
    
    class func showAlert(title: String?, message: String?, completionHandler: (() -> Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //add OK button on alert dialog
        alert.addAction(UIAlertAction(title: AppManager.ESLocalized(key: "OK"), style: .default, handler: { (action) in
            completionHandler?()
        }))
        DispatchQueue.main.async {
            if var topViewController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topViewController.presentedViewController {
                    topViewController = presentedViewController
                }
                if let navigationController = (topViewController as? UINavigationController) {
                    topViewController = navigationController.visibleViewController!
                }
                if let tabBarController = topViewController as? UITabBarController {
                    topViewController = tabBarController.selectedViewController!
                }
                
                // topViewController should now be your currently visible controller
                topViewController.present(alert, animated: false, completion: nil)
            }
        }
    }
    
//    class func showMessageInToast(title: String, body: String) {
//        let view = MessageView.viewFromNib(layout: .cardView)
//        view.configureTheme(.success)
//        view.configureDropShadow()
//        view.configureContent(title: title, body: body)
//        view.configureIcon(withSize: CGSize.zero)
//        view.configureTheme(backgroundColor: UIColor.init(hexString: "43A047")!, foregroundColor: UIColor.white)
//        view.button?.isHidden = true
//        SwiftMessages.show(view: view)
//    }
    
//    class func showToast(title: String, body: String, contextView: UIView, theme: Theme) {
//        var config = SwiftMessages.Config()
//        config.presentationContext = .view(contextView)
//
//        let view = MessageView.viewFromNib(layout: .cardView)
//        view.configureTheme(theme)
//        view.configureDropShadow()
//        view.configureContent(title: title, body: body)
//        view.configureIcon(withSize: CGSize.zero)
//        view.button?.isHidden = true
//
//        if theme == .success {
//            view.configureTheme(backgroundColor: UIColor.init(hexString: "43A047")!, foregroundColor: UIColor.white)
//        }else if theme == .error {
//            view.configureTheme(backgroundColor: UIColor.init(hexString: "E53935")!, foregroundColor: UIColor.white)
//            config.duration = .seconds(seconds: 3.5)
//        }
//        SwiftMessages.show(config: config, view: view)
//    }
    
    class func setupTouchBlocker() {
//        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            touchBlocker = TouchBlocker(frame: CGRect.zero)
            touchBlocker?.translatesAutoresizingMaskIntoConstraints = false
            appDelegate?.window?.addSubview(touchBlocker!)
            appDelegate?.window?.addConstraint(NSLayoutConstraint(item: touchBlocker!, attribute: .top, relatedBy: .equal, toItem: appDelegate?.window, attribute: .top, multiplier: 1, constant: 0))
            appDelegate?.window?.addConstraint(NSLayoutConstraint(item: touchBlocker!, attribute: .left, relatedBy: .equal, toItem: appDelegate?.window, attribute: .left, multiplier: 1, constant: 0))
            appDelegate?.window?.addConstraint(NSLayoutConstraint(item: touchBlocker!, attribute: .right, relatedBy: .equal, toItem: appDelegate?.window, attribute: .right, multiplier: 1, constant: 0))
            appDelegate?.window?.addConstraint(NSLayoutConstraint(item: touchBlocker!, attribute: .bottom, relatedBy: .equal, toItem: appDelegate?.window, attribute: .bottom, multiplier: 1, constant: 0))
//        }
    }
    
    class func showLoading() -> Void {
        guard touchBlocker != nil else {
            setupTouchBlocker()
            showLoading()
            return
        }
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.bringSubview(toFront: self.touchBlocker!)
        }
        touchBlocker!.showLoading()
    }
    
    class func hideLoading() -> Void {
        touchBlocker?.hideLoading()
    }
    
    class func isIpad() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }
        return false
    }
    
    class func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = color
    }
    
    class func ESLocalized(key: String) -> String{
        let stringValue =  NSLocalizedString(key, tableName: nil, bundle: Bundle(for: self.classForCoder()), value: "", comment: "")
        return stringValue
    }
    
    class func localisedCurrencyString(value:Double, currencySymbol:String) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = currencySymbol
        numberFormatter.paddingCharacter = " "
        numberFormatter.paddingPosition = .afterPrefix
        numberFormatter.formatWidth = 6
        numberFormatter.locale = NSLocale.current
        return numberFormatter.string(from: NSDecimalNumber.init(value: value))!
    }
}

extension String {
    static func isValidEmail(_ testStr:String) -> Bool {
        print("validate emailId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        var hexColor = hexString
        
        if hexString.hasPrefix("#") {
//            let start = hexString.characters.index(hexString.startIndex, offsetBy: 1)
//            hexColor = hexString.substring(from: start)
            hexColor = String(hexString[..<hexString.index(hexString.startIndex, offsetBy: 1)])
        }
        
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }else if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000ff) / 255
                a = 1
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        return nil
    }
}

extension UIImageView {
    public func imageFromURL(urlString: String, defaultImage: UIImage?) {
        
//        self.sd_setImage(with: URL(string: urlString), placeholderImage: defaultImage)
        
//        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
//            
//            if error != nil {
//                print(error as Any)
//                return
//            }
//            DispatchQueue.main.async(execute: { () -> Void in
//                let image = UIImage(data: data!)
//                self.image = image
//            })
//            
//        }).resume()
    }
}

extension UIViewController {
    var previousViewController:UIViewController?{
        if let controllersOnNavStack = self.navigationController?.viewControllers, controllersOnNavStack.count >= 2 {
            let n = controllersOnNavStack.count
            return controllersOnNavStack[n - 2]
        }
        return nil
    }
}

extension UITextField {
    public func highlightBorder(borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func removeHighlight() {
        self.layer.borderWidth = 0
    }
}

extension UIButton {
    func applyShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
    }
}
