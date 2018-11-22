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
    @IBOutlet weak var sortTypeLabel: UILabel!
    
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
        configureView()
        setNeedsStatusBarAppearanceUpdate()

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        configureView()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    private func configureView() {
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.bounds = self.view.frame
        self.collectionView.collectionViewLayout = ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
        let gradient = CAGradientLayer(layer: CAGradientLayer.self)
        gradient.frame = (navigationController?.navigationBar.bounds)!
        gradient.colors = [#colorLiteral(red: 0.3529286683, green: 0.4166716933, blue: 0.6964689493, alpha: 1).cgColor, #colorLiteral(red: 0.5466880202, green: 0.21522066, blue: 0.6038900614, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        if let image = getImageFrom(gradientLayer: gradient) {
            navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
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
