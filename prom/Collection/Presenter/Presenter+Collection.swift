//
//  Presenter+Collection.swift
//  prom
//
//  Created by Alyona Hulak on 11/18/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import Foundation
import UIKit
import IGListKit


class CollectionPresenter: BasePresenter<CollectionViewController>, CoreDataObjectsObserverProtocol {
    
    private var service: DataRequest
    private var reloadResultsOserver: Any?
    var coreDataObjectsObserver: CoreDataObjectsObserver<Results>?
    lazy var adapter: ListAdapter =  {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self.viewController, workingRangeSize: 0)
        adapter.collectionView = self.viewController!.collectionView
        adapter.dataSource = CatalogDataSource()
        return adapter
    }()
    
    
    init(viewController: CollectionViewController,
         router: Router,
         service: DataRequest) {
        self.service = service
        super.init(viewController: viewController, router: router)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureView()
        _ = self.viewController?.adapter
//        performUpdatesForCoreDataChange(animated: false)
    }
    

    private func configureView() {
        self.viewController!.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.viewController!.collectionView.collectionViewLayout = ListCollectionViewLayout(stickyHeaders: true, topContentInset: 0, stretchToEdge: false)
//        self.viewController?.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    
    func performUpdatesForCoreDataChange(animated: Bool) {
        // Updating contents of collection view
        self.adapter.performUpdates(animated: animated)
    }

    
}
