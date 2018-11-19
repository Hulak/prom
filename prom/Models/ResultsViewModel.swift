//
//  ResultsViewModel.swift
//  prom
//
//  Created by Alyona Hulak on 11/17/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.

import Foundation
import IGListKit

class ResultViewModel: NSObject {
    var id: Int64 = 0
    var name: String = ""
    var price: String = ""
    var presenceTitle: String = ""
    var discountedPrice: String = ""
    var priceCurrency: String = ""
    var urlMainImage: String = ""
    init(id: Int64, name: String, price: String, discountedPrice: String, priceCurrency: String, presenceTitle: String) {
        self.id = id
        self.name = name
        self.price = price
        self.priceCurrency = priceCurrency
        
        
    }
}

extension ResultViewModel {
    static func fromCoreData(result: Results) -> ResultViewModel {
        // - Note: For avoiding Core Data threading violation, the following code should be wrapped in a
        // user.managedObjectContext?.performAndWait {}
        return ResultViewModel(id: result.id, name: result.name, price: result.price, discountedPrice: result.discountedPrice, priceCurrency: result.priceCurrency, presenceTitle: result.presenceTitle)
    }
}

extension ResultViewModel: ListDiffable {
    
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
