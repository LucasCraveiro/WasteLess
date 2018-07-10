//
//  ViewController.swift
//  WasteLess
//
//  Created by Lucas Craveiro on 2018-06-19.
//  Copyright © 2018 Lucas Craveiro. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var groceryTableView: UITableView!
    var groceryList: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groceryTableView.delegate = self
        self.groceryTableView.dataSource = self
        title = "Waste Less"
//        groceryTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // fetch data from the database.
        super.viewWillAppear(animated)
        getData()
        groceryTableView.reloadData()
        
    }
    
    func getData() {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Product")
        let sortDescriptors = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptors]
        
        //3
        do {
            groceryList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let food = groceryList[indexPath.row]
        
        let cell = groceryTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customTableViewCell
        
        cell.foodName.text = food.value(forKeyPath: "name") as? String
        let date = food.value(forKeyPath: "expiryDate") as! Date
        cell.expiryDate.text = date.description

        return cell
    }
}

// database : array

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            // ToDo: Delete
            let food = self.groceryList[indexPath.row]
            
            //1
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            //2
            let managedContext =
                appDelegate.persistentContainer.viewContext
            //3
            managedContext.delete(food)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //4
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "Product")
            let sortDescriptors = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptors]
            //5
            do {
                self.groceryList = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        
            tableView.reloadData()
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "trash")
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Update") { (action, view, completion) in
            // ToDo: Update
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "pencil")
        action.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [action])
    }
}

//extension ViewController: NSFetchedResultsControllerDelegate {
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        groceryTableView.beginUpdates()
//    }
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        groceryTableView.endUpdates()
//    }
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            if let indexPath = newIndexPath {
//                groceryTableView.insertRows(at: [indexPath], with: .automatic)
//            }
//        default:
//            break
//        }
//    }
//}
