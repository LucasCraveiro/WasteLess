//
//  customTableViewCell.swift
//  WasteLess
//
//  Created by Lucas Craveiro on 2018-06-21.
//  Copyright © 2018 Lucas Craveiro. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var expiryDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
