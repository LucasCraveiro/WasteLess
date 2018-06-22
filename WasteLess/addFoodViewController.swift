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
        
        var components = DateComponents()
        components.year = -100
        let minDate = Calendar.current.date(byAdding: components, to: Date())
        
        
        self.datePicker.minimumDate = minDate

    }

    

}
