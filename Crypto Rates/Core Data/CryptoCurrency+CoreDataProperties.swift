//
//  CryptoCurrency+CoreDataProperties.swift
//  Crypto Rates
//
//  Created by Macbook Air on 06/12/17.
//  Copyright © 2017 srb. All rights reserved.
//
//

import Foundation
import CoreData


extension CryptoCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CryptoCurrency> {
        return NSFetchRequest<CryptoCurrency>(entityName: "CryptoCurrency")
    }

    @NSManaged public var name: String?
    @NSManaged public var buyRate: Double
    @NSManaged public var sellRate: Double
    @NSManaged public var exchange: String?
    @NSManaged public var timestamp: NSDate?

}
