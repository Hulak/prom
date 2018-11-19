//
//  Results+CoreDataClass.swift
//  prom
//
//  Created by Alyona Hulak on 11/15/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import Foundation
import CoreData
import IGListKit

@objc(Results)
public class Results: NSManagedObject, Decodable, CoreDataObjectsObserverProtocol {
    
    enum CodingKeys: String, CodingKey {
        case id    = "id"
        case name = "name"
        case price = "price"
        case presenceTitle = "presence_title"
        case discountedPrice = "discounted_price"
        case priceCurrency = "price_currency"
        case urlMainImage = "url_main_image_200x200"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Results", in: managedObjectContext) else {
                fatalError("Failed to decode Results!")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int64.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        price = try values.decode(String.self, forKey: .price)
        presenceTitle = try values.decode(String.self, forKey: .presenceTitle)
        discountedPrice = try values.decode(String.self, forKey: .discountedPrice)
        priceCurrency = try values.decode(String.self, forKey: .priceCurrency)
        urlMainImage = try values.decode(String.self, forKey: .urlMainImage)
        
    }
    
}

