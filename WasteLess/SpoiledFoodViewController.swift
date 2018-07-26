//
//  SpoiledFoodViewController.swift
//  WasteLess
//
//  Created by Lucas Craveiro on 2018-07-23.
//  Copyright © 2018 Lucas Craveiro. All rights reserved.
//

import UIKit
import CoreData

class SpoiledFoodViewController: UIViewController {
   
    @IBOutlet weak var spoiledGroceryTableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var messageLabel: UILabel!
    
    var spoiledGroceryList: [NSManagedObject] = [] {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spoiledGroceryTableView.delegate = self
        self.spoiledGroceryTableView.dataSource = self
        let tabBarTitle = UITabBarItem()
        tabBarTitle.title = "Spoiled Food"
        title = "Spoiled Food"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // fetch data from the database.
        super.viewWillAppear(animated)
        getData()
        setupView()
        spoiledGroceryTableView.reloadData()
        
    }
    
    private func updateView() {
        let hasGroceryList = spoiledGroceryList.count > 0
        
        spoiledGroceryTableView.isHidden = !hasGroceryList
        messageLabel.isHidden = hasGroceryList
        activityIndicatorView.stopAnimating()
    }
    
    private func setupView() {
        setupMessageLabel()
        
        updateView()
    }
    
    private func setupMessageLabel() {
        messageLabel.text = "You don't have any groceries yet."
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
        let fetchRequest1 =
            NSFetchRequest<NSManagedObject>(entityName: "Product")
        let sortDescriptors = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest1.sortDescriptors = [sortDescriptors]
        let currentDate = Date()
        fetchRequest1.predicate = NSPredicate(format: "expiryDate < %@", currentDate as CVarArg)
        
        //3
        do {
            spoiledGroceryList = try managedContext.fetch(fetchRequest1)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension SpoiledFoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spoiledGroceryList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let food = spoiledGroceryList[indexPath.row]
        
        let cell = spoiledGroceryTableView.dequeueReusableCell(withIdentifier: "SpoiledCell", for: indexPath) as! SpoiledTableViewCell
        
        
        cell.foodNameSpoiled.text = food.value(forKeyPath: "name") as? String
        let date = food.value(forKeyPath: "expiryDate") as! Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let stringDate = dateFormatter.string(from: date)
        
        cell.expiredDate.text = stringDate.description
        
        return cell
    }
}

// Database : Array and Core Data - Delete and Update

extension SpoiledFoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Delete from Core Data
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            // ToDo: Delete
            let food = self.spoiledGroceryList[indexPath.row]
            
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
            let fetchRequest1 =
                NSFetchRequest<NSManagedObject>(entityName: "Product")
            let sortDescriptors = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest1.sortDescriptors = [sortDescriptors]
            let currentDate = Date()
            
            fetchRequest1.predicate = NSPredicate(format: "expiryDate < %@", currentDate as CVarArg)
            //5
            do {
                self.spoiledGroceryList = try managedContext.fetch(fetchRequest1)
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
    
    // Fix the height of cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //Changes the cells background
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            let altCellColor: UIColor? = UIColor(red:0.94, green:0.96, blue:0.76, alpha:0.5)
            cell.backgroundColor = altCellColor
        } else {
            let altCellColor: UIColor? = UIColor(red:0.86, green:0.93, blue:0.78, alpha:0.5)
            cell.backgroundColor = altCellColor
        }
    }
}
