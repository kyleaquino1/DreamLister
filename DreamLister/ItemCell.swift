//
//  ItemCell.swift
//  DreamLister
//
//  Created by Kyle on 7/21/17.
//  Copyright © 2017 Kyle Aquino. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var materialView: UIView!
    
    func configureCell(item: Item) {
        
        materialView.materialDesign = true
        titleLabel.text = item.title
        priceLabel.text = "$\(item.price)"
        detailLabel.text = item.details
        thumbImage.image = item.toImage?.image as? UIImage
        
    }

}
