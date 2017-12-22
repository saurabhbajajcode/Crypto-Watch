//
//  APIHandler.swift
//  Craftsmen
//
//  Created by Macbook Air on 08/06/17.
//  Copyright © 2017 Promobi. All rights reserved.
//

import UIKit

class APIHandler: NSObject, URLSessionDelegate {

    static let timeoutInterval:TimeInterval = 10
    
//    class func login(email: String, password: String, completionHandler: @escaping (_ responseObject: [String: AnyObject]) -> Void) {
//        let request = NSMutableURLRequest(url: URL.init(string: "\(baseURL)\(apiLogin)")!)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//
//        var parameters = ["email":email, "password":password]
//        parameters[languageKey] = UserDefaults.standard.value(forKey: languageKey) as? String
//        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//        request.httpBody = jsonData
//
//        executeRequest(request: request) { (responseObject) in
//            let responseDict = responseObject as? [String: AnyObject]
//            guard let status = responseDict?["status"] else { return }
//            if (status as? String)?.lowercased() == "false" {
//                if let errorMessage = responseDict?["error"] {
//                    AppManager.showAlert(title: AppManager.ESLocalized(key: "Error"), message: errorMessage as? String, completionHandler: nil)
//                }else {
//                    AppManager.showAlert(title: AppManager.ESLocalized(key: "Error"), message: commonErrorMessage, completionHandler: nil)
//                }
//            }else {
//                completionHandler(responseDict!)
//            }
//        }
//    }
    
    class func getZebpayRates(completionHandler: @escaping (_ responseObject: [String: AnyObject]) -> Void) {
        let request = NSMutableURLRequest(url: URL.init(string: "https://www.zebapi.com/api/v1/market/ticker/btc/inr")!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
//        var parameters = ["email":email, "password":password]
//        parameters[languageKey] = UserDefaults.standard.value(forKey: languageKey) as? String
//        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//        request.httpBody = jsonData
        
        executeRequest(request: request) { (responseObject) in
            let responseDict = responseObject as? [String: AnyObject]
//            guard let status = responseDict?["status"] else { return }
//            if (status as? String)?.lowercased() == "false" {
//                if let errorMessage = responseDict?["error"] {
//                    AppManager.showAlert(title: AppManager.ESLocalized(key: "Error"), message: errorMessage as? String, completionHandler: nil)
//                }else {
//                    AppManager.showAlert(title: AppManager.ESLocalized(key: "Error"), message: commonErrorMessage, completionHandler: nil)
//                }
//            }else {
                completionHandler(responseDict!)
//            }
        }
    }
    
    class func executeRequest(request: NSMutableURLRequest, completionHandler: @escaping (_ responseDict: Any?) -> Void) {
        AppManager.showLoading()
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = timeoutInterval
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                        completionHandler(json)
                    } else {
                        completionHandler(json)
                    }
                    AppManager.hideLoading()
                }catch let error as NSError {
                    print(error.localizedDescription)
                    AppManager.hideLoading()
//                    AppManager.showAlert(title: AppManager.ESLocalized(key: "Error"), message: commonErrorMessage, completionHandler: nil)
                }
            }else if error != nil {
                print(error!)
                AppManager.hideLoading()
//                AppManager.showAlert(title: AppManager.ESLocalized(key: "Error"), message: (error?.localizedDescription)!, completionHandler: {
//                    NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "alertDismissed")))
//                })
            }
        }
        task.resume()
    }
    
    
    //MARK:- helpers
//    private class func authoriseRequestParams(params: [String: AnyObject]) -> [String:AnyObject] {
//        var parameters = params
//        parameters[accessTokenKey] = UserDefaults.standard.value(forKey: accessTokenKey) as? String as AnyObject
//        parameters["craftsmenId"] = UserDefaults.standard.value(forKey: customerIdKey) as? String as AnyObject
//        parameters[adminUsernameKey] = UserDefaults.standard.value(forKey: adminUsernameKey) as? String as AnyObject
//        parameters[languageKey] = UserDefaults.standard.value(forKey: languageKey) as AnyObject
//        return parameters
//    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
