//
//  ViewController.swift
//  Crypto Rates
//
//  Created by Macbook Air on 27/11/17.
//  Copyright © 2017 srb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buyValueLabel: UILabel!
    @IBOutlet weak var sellValueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        loadData()
        refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        APIHandler.getZebpayRates { (responseDict) in
            if let buyRate = responseDict["buy"] {
                DispatchQueue.main.async {
                    self.buyValueLabel.text = "₹ "+String(describing: buyRate)
                }
            }
            if let sellRate = responseDict["sell"] {
                DispatchQueue.main.async {
                    self.sellValueLabel.text = "₹ "+String(describing: sellRate)
                }
            }
        }
    }
    
    func refreshData() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { (timer) in
            APIHandler.getZebpayRates { (responseDict) in
                self.saveUpdatedValues(response: responseDict)
                print("Data refreshed...")
            }
        }
    }
    
    func saveUpdatedValues(response: [String: AnyObject]) {
        print(response)
        var oldBuy = 0.0
        var oldSell = 0.0
        let oldRecord = CryptoCurrency.getLastUpdate(for: "Bitcoin", exchange: "Zebpay")
        if oldRecord != nil {
            oldBuy = oldRecord!.buyRate
            oldSell = oldRecord!.sellRate
        }
        var newBuy:Double = oldBuy
        var newSell:Double = oldSell
        if let buyRate = response["buy"] {
            newBuy = Double(truncating: buyRate as! NSNumber)
        }
        if let sellRate = response["sell"] {
            newSell = Double(truncating: sellRate as! NSNumber)
        }
        if oldBuy != newBuy || oldSell != newSell {
            let newCurrency = CryptoCurrency.getNewObject()
            newCurrency.timestamp = Date() as NSDate
            newCurrency.name = "Bitcoin"
            newCurrency.exchange = "Zebpay"
            newCurrency.buyRate = newBuy
            newCurrency.sellRate = newSell
            CoreDataManager.saveContext()
        }
//        DispatchQueue.main.async {
//            self.buyValueLabel.text = "₹ "+String(describing: newBuy)
//            self.sellValueLabel.text = "₹ "+String(describing: newSell)
//        }
        tableData = CryptoCurrency.getAllCurrencies()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    var tableData:[CryptoCurrency]? = CryptoCurrency.getAllCurrencies()
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        cell?.textLabel?.text = tableData![indexPath.row].buyRate.description
        cell?.detailTextLabel?.text = tableData![indexPath.row].sellRate.description
        if indexPath.row == 0 {
            let oldBuy = tableData![1].buyRate
            let oldSell = tableData![1].sellRate
            let newBuy = tableData![0].buyRate
            let newSell = tableData![0].sellRate
            cell?.textLabel?.textColor = newBuy > oldBuy ? UIColor.green : UIColor.red
            cell?.detailTextLabel?.textColor = newSell > oldSell ? UIColor.green : UIColor.red
        }else {
            cell?.textLabel?.textColor = UIColor.black
            cell?.detailTextLabel?.textColor = UIColor.black
        }
        return cell!
    }
}
