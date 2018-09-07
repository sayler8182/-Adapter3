//
//  Model.swift
//  Adapters
//
//  Created by Konrad on 27/08/2018.
//  Copyright © 2018 Konrad. All rights reserved.
//

import Foundation

struct Model: ItemModel {
    let x: Int
    let y: Int
    
    var description: String {
        return String(format: "%d - %d", self.x, self.y)
    }
}
