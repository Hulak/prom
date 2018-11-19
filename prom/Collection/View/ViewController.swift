//
//  ViewController.swift
//  prom
//
//  Created by Alyona Hulak on 11/13/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import UIKit
import IGListKit

class CollectionViewController: BaseViewController {
 
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: ResultViewModel?
    lazy var adapter: ListAdapter =  {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self, workingRangeSize: 0)
        adapter.collectionView = self.collectionView
        adapter.dataSource = CatalogDataSource()
        return adapter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

}
