//
//  ViewLifecycleDelegate.swift
//  prom
//
//  Created by Alyona Hulak on 11/18/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

protocol ViewLifecycleDelegate: class {
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    
}
