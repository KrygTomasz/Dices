//
//  Dice.swift
//  Dices
//
//  Created by Krygu on 27/02/2019.
//  Copyright © 2019 Krygu. All rights reserved.
//

import Foundation

class Dice {
    
    var sides: Int
    var label: String {
        return "k\(sides)"
    }
    
    init(sides: Int) {
        self.sides = sides
    }
    
    func roll() -> Int {
        return Int.random(in: 1...sides)
    }
    
}
