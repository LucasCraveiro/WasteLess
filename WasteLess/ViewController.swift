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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // fetch data from the database.
        super.viewWillAppear(animated)
        
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
        cell.expiryDate.text = food.value(forKeyPath: "expiryDate") as? String

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}
