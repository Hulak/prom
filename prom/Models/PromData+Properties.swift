//
//  Catalogg+Properties.swift
//  prom
//
//  Created by Alyona Hulak on 11/17/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import CoreData

extension PromData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PromData> {
        let request = NSFetchRequest<PromData>(entityName: "PromData")
        return request
    }
    
    @NSManaged public var catalog: Catalog
    
}
