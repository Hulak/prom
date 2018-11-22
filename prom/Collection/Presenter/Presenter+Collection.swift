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
    
//        configureView()
        _ = self.viewController?.adapter
        self.viewController!.setNeedsStatusBarAppearanceUpdate()
        self.adapter.performUpdates(animated: true)

    }


    private func configureView() {
        self.viewController!.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.viewController!.collectionView.collectionViewLayout = ListCollectionViewLayout(stickyHeaders: true, topContentInset: 0, stretchToEdge: false)
        
        let gradient = CAGradientLayer(layer: CAGradientLayer.self)
        gradient.frame = (self.viewController?.navigationController?.navigationBar.bounds)!
        gradient.colors = [#colorLiteral(red: 0.3529286683, green: 0.4166716933, blue: 0.6964689493, alpha: 1), #colorLiteral(red: 0.5466880202, green: 0.21522066, blue: 0.6038900614, alpha: 1)]
        gradient.locations = [0.0, 1.0, 1.0, 1.0]
        if let image = getImageFrom(gradientLayer: gradient) {
            self.viewController?.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    
    func performUpdatesForCoreDataChange(animated: Bool) {
        // Updating contents of collection view
        self.adapter.performUpdates(animated: animated)
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}
