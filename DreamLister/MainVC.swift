//
//  MainVC.Swift
//  DreamLister
//
//  Created by Kyle Aquino on 7/21/17.
//  Copyright © 2017 Kyle Aquino. All rights reserved.
//

import UIKit
import CoreData


class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        //generateTestData()
        attemptFetch()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
            
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = controller.fetchedObjects , objs.count > 0 {
            
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailVC", sender: item)
            
        }
        
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        
        //update the cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }

    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        
        if segmentedControl.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [dateSort]
        } else if segmentedControl.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [priceSort]
        } else if segmentedControl.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [titleSort]
        }
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil , cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
        
        
        
    }
    
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        attemptFetch()
        tableView.reloadData()
        
        
    }
    
    
    
    
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            if let indexPath = newIndexPath {
                
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
        
    }
    
    func generateTestData() {
        
        let item = Item(context: context)
        
        item.title = "MacBook Pro"
        item.price = 1800
        item.details = "I cannot wait to get my hands on the New MacBook Pro!!!"
        
        let item2 = Item(context: context)
        
        item2.title = "Air Pods"
        item2.price = 160
        item2.details = "I cannot wait to get my hands on the New Apple Air Pods!!!"
        
        let item3 = Item(context: context)
        
        item3.title = "Apple Watch"
        item3.price = 350
        item3.details = "I cannot wait to get my hands on the New Apple Watch 3!!!"
        
        ad.saveContext()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailVC" {
            
            if let destination = segue.destination as? ItemDetailVC {
                
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
                
            }
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

