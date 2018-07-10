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
    private var pickedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFood.delegate = self
        // Adjusting minimumDate (DatePicker for current day)
        let currentDate = Date()
        self.datePicker.minimumDate = currentDate
    }

    @IBAction func addFood(_ sender: Any) {
        // get food name
        let foodToSave = textFood.text
        // get date and change to string
        let dateToSave = datePicker.date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM dd, YYYY"
//        let stringDate = dateFormatter.string(from: dateToSave)
        let idFood = UUID()
        //object created
        let foodInformation = Food(id: idFood, name: foodToSave!, expiryDate: dateToSave, isExpired: false)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext

        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Product",
                                       in: managedContext)!

        let food = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        // 3
        food.setValue(foodInformation.id, forKeyPath: "id")
        food.setValue(foodInformation.name, forKey: "name")
        food.setValue(foodInformation.expiryDate, forKey: "expiryDate")
        food.setValue(foodInformation.isExpired, forKey: "isExpired")
        // 4
        do {
            try managedContext.save()
            self.navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
// Keyboard goes down when you type return
extension addFoodViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




