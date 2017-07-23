//
//  MyMaterialView.swift
//  DreamLister
//
//  Created by Kyle on 7/22/17.
//  Copyright © 2017 Kyle Aquino. All rights reserved.
//

import UIKit

class MyMaterialView: UIView {
    
    override func awakeFromNib() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8.0
        self.layer.opacity = 1.0
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 0 , green: 0, blue: 0, alpha: 1.0).cgColor
        self.layer.shadowOpacity = 1.0
        
        //self.layer.isOpaque = true
        //self.layer.backgroundColor = UIColor(red: 0 , green: 0, blue: 0, alpha: 1.0).cgColor
        
        
    }
    
}
