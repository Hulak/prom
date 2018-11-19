//
//  Catalog+CoreDataClass.swift
//  prom
//
//  Created by Alyona Hulak on 11/17/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import Foundation
import CoreData
import IGListKit

@objc(Catalog)
public class Catalog: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case possibleSorts = "possible_sorts"
        case results = "results"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Catalog", in: managedObjectContext) else {
                fatalError("Failed to decode Catalog!")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        possibleSorts = try values.decode([String].self, forKey: .possibleSorts)
        let result = try values.decode([Results].self, forKey: .results)
        results = NSOrderedSet(array: result)
        
    }
}
