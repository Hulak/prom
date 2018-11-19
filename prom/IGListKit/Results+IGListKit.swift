//
//  Results+ListDiffable.swift
//  prom
//
//  Created by Alyona Hulak on 11/17/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//
import IGListKit
import CoreData

extension Results: ListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return NSString(string: "\(id)")
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let toObject = object as? Results else { return false }
        
        return self.id == toObject.id
            && self.name == toObject.name
            && self.price == toObject.price
            && self.discountedPrice == toObject.discountedPrice
            && self.priceCurrency == toObject.priceCurrency
            && self.urlMainImage == toObject.urlMainImage
    }
}

