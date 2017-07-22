//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Kyle on 7/21/17.
//  Copyright © 2017 Kyle Aquino. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
    
    
}
