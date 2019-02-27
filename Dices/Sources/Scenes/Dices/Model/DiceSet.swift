//
//  DiceSet.swift
//  Dices
//
//  Created by Krygu on 27/02/2019.
//  Copyright © 2019 Krygu. All rights reserved.
//

import Foundation

class DiceSet {
    
    var dices: [Dice]
    
    init(dices: [Dice]) {
        self.dices = dices
    }
    
    func roll() -> [Int] {
        return dices.map { $0.roll() }
    }
    
}
