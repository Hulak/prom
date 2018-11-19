//
//  Router+Collection.swift
//  prom
//
//  Created by Alyona Hulak on 11/18/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import Foundation
import UIKit
import CoreData

private let collectionStoryboard = "Collection"

extension Router {
    
    static func instantiateActivationViewController() -> CollectionViewController {
        let storyboard = UIStoryboard(name: collectionStoryboard, bundle: nil)
        let view = storyboard.instantiateInitialViewController() as! CollectionViewController
        let router = Router(view: view)
        let service = DataRequest()
        let presenter = CollectionPresenter(viewController: view,
                                            router: router,
                                            service: service)
        presenter.coreDataObjectsObserver?.delegate = presenter
        view.presenter = presenter
        return view
    }
}
