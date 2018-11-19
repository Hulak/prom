//
//  Results+Properties.swift
//  prom
//
//  Created by Alyona Hulak on 11/15/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import CoreData

extension Results {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Results> {
        let request = NSFetchRequest<Results>(entityName: "Results")
        return request
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var price: String
    @NSManaged public var presenceTitle: String
    @NSManaged public var discountedPrice: String
    @NSManaged public var priceCurrency: String
    @NSManaged public var urlMainImage: String
}
