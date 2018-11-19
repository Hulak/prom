//
//  CatalogSectionController.swift
//  prom
//
//  Created by Alyona Hulak on 11/17/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//
import Foundation
import IGListKit

class CatalogSectionController: ListSectionController, ListDisplayDelegate {
    var currentResult: Results?
    
    override init() {
        super.init()
        displayDelegate = self
    }
    
    override func didUpdate(to object: Any) {
        guard let result = object as? Results else {
            return
        }
        currentResult = result
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 200, height: 400)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        guard let result = currentResult else {
            return cell
        }
        
        if let resultCell = getCell(at: index) {
            cell = resultCell
        }
        
        guard let resultCell = cell as? ResultsUpdatable else {
            return cell
        }
        resultCell.updateWith(result: result)
        return cell
    }
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
    }
}
extension CatalogSectionController {
    private func getCell(at index: Int) -> UICollectionViewCell? {
        guard let ctx = collectionContext else {
            return UICollectionViewCell()
        }
        let nibName = String(describing: ResultsCollectionViewCell.self)
        let cell = ctx.dequeueReusableCell(withNibName: nibName , bundle: nil, for: self, at: index)
        return cell
    }
}
