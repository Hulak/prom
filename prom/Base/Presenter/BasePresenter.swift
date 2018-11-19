//
//  BasePresenter.swift
//  prom
//
//  Created by Alyona Hulak on 11/18/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import UIKit

class BasePresenter<V: UIViewController>: Presenter {
    
    weak var viewController: V?
    let router: Router
    
    init(viewController: V, router: Router) {
        self.viewController = viewController
        self.router = router
    }
    
    // MARK: ViewLifecycleDelegate
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
