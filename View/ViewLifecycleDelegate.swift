//
//  ViewLifecycleDelegate.swift
//  Modern Paper
//
//  Created by Oleg Poliukhovych on 5/19/18.
//  Copyright © 2018 MOBOX. All rights reserved.
//

protocol ViewLifecycleDelegate: class {

    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()

}
