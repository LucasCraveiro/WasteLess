//
//  SpoiledTableViewCell.swift
//  WasteLess
//
//  Created by Lucas Craveiro on 2018-07-25.
//  Copyright © 2018 Lucas Craveiro. All rights reserved.
//

import UIKit

class SpoiledTableViewCell: UITableViewCell {

    @IBOutlet weak var foodNameSpoiled: UILabel!
    @IBOutlet weak var expiredDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
