//
//  Food.swift
//  WasteLess
//
//  Created by Lucas Craveiro on 2018-06-21.
//  Copyright © 2018 Lucas Craveiro. All rights reserved.
//

import Foundation

struct Food {
    var id: UUID
    var name: String
    var expiryDate: Date
    var isExpired: Bool
}
