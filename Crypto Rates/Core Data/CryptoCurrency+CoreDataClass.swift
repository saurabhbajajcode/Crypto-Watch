//
//  CryptoCurrency+CoreDataClass.swift
//  Crypto Rates
//
//  Created by Macbook Air on 06/12/17.
//  Copyright © 2017 srb. All rights reserved.
//
//

import Foundation
import CoreData


public class CryptoCurrency: NSManagedObject {

    class func getNewObject() -> CryptoCurrency {
        return NSEntityDescription.insertNewObject(forEntityName: "CryptoCurrency", into: CoreDataManager.context) as! CryptoCurrency
    }
    
    class func insertCurrency() -> CryptoCurrency {
        let newCurrency = getNewObject()
        return newCurrency
    }
    
    class func getAllCurrencies() -> [CryptoCurrency]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CryptoCurrency")
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let currencies = try CoreDataManager.context.fetch(fetchRequest)
            return currencies as? [CryptoCurrency]
        }catch {
            
        }
        return nil
    }
    
    class func getLastUpdate(for currencyName: String, exchange: String) -> CryptoCurrency? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CryptoCurrency")
        let predicate = NSPredicate(format: "name==%@ && exchange==%@", currencyName, exchange)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 1
        do {
            let result = try CoreDataManager.context.fetch(fetchRequest)
            if !result.isEmpty {
                return result.first as? CryptoCurrency
            }
        }catch {
            
        }
        return nil
    }
    
}
