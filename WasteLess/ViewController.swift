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
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groceryTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customTableViewCell
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}
