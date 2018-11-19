//
//  Catalog+Properties.swift
//  prom
//
//  Created by Alyona Hulak on 11/17/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import CoreData

extension Catalog {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Catalog> {
        let request = NSFetchRequest<Catalog>(entityName: "Catalog")
        return request
    }
    
    @NSManaged public var possibleSorts: [String]
    @NSManaged public var results: NSOrderedSet
    

}

