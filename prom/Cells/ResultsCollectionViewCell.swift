//
//  CatalogCollectionViewCell.swift
//  prom
//
//  Created by Alyona Hulak on 11/17/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import UIKit
import Lottie

class ResultsCollectionViewCell: UICollectionViewCell, ResultsUpdatable {
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var presenceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBAction func buyButton(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Продукт добавлен в корзину", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "Продукт добавлен в избранное", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func updateWith(result: Results) {
        nameLabel.text = result.name
        presenceLabel.text = result.presenceTitle
        priceLabel.text = result.price + result.priceCurrency
        imageIcon.downloaded(from: result.urlMainImage)
}
}
