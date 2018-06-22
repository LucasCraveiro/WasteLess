//
//  addFoodViewController.swift
//  WasteLess
//
//  Created by Lucas Craveiro on 2018-06-21.
//  Copyright © 2018 Lucas Craveiro. All rights reserved.
//

import UIKit
import CoreData

class addFoodViewController: UIViewController {

    
    @IBOutlet weak var addFoodLabel: UILabel!
    @IBOutlet weak var textFood: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textFood.delegate = self
        
        // Adjusting minimumDate (DatePicker for current day)
        let currentDate = Date()
        self.datePicker.minimumDate = currentDate
        
    }

    @IBAction func addFood(_ sender: Any) {
        print("ok")
        
    }
    
}
// Keyboard goes down when you type return
extension addFoodViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




