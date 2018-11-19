//
//  Catalogg+CoreDataClass.swift
//  prom
//
//  Created by Alyona Hulak on 11/17/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import Foundation
import CoreData

@objc(PromData)
public class PromData: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case catalog = "catalog"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "PromData", in: managedObjectContext) else {
                fatalError("Failed to decode data!")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        catalog = try values.decode(Catalog.self, forKey: .catalog)
        
    }
}
