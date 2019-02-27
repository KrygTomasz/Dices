//
//  DicesViewModel.swift
//  Dices
//
//  Created by Krygu on 27/02/2019.
//  Copyright © 2019 Krygu. All rights reserved.
//

import RxSwift
import RxCocoa

protocol DiceProvider {
    
    var dices: [Dice] { get }
    
}

class DiceProviderImpl: DiceProvider {
    
    var dices: [Dice] = [Dice(sides: 4),
                         Dice(sides: 6),
                         Dice(sides: 8),
                         Dice(sides: 10),
                         Dice(sides: 12),
                         Dice(sides: 20),
                         Dice(sides: 100)]
    
}

protocol DicesViewModel {
    var diceProvider: DiceProvider { get }
    var dicesQuantityArray: [Int] { get }
    
    var selectedDice: PublishRelay<Dice> { get }
    var selectedQuantity: PublishRelay<Int> { get }
    var rollResults: Observable<[Int]> { get }
}

class DicesViewModelImpl: DicesViewModel {
    
    var diceProvider: DiceProvider
    var dicesQuantityArray: [Int] {
        return Array((1...dicesQuantity))
    }

    var selectedDice: PublishRelay<Dice> = PublishRelay()
    var selectedQuantity: PublishRelay<Int> = PublishRelay()
    var rollResults: Observable<[Int]> {
        return Observable.combineLatest(self.selectedDice, self.selectedQuantity)
            .asObservable()
            .map { (dice, quantity) -> [Int] in
                var rolls: [Int] = []
                for _ in 0..<quantity {
                    rolls.append(dice.roll())
                }
                return rolls
            }
    }
    
    
    private var dicesQuantity: Int
    
    init(diceProvider: DiceProvider, dicesQuantity: Int) {
        self.diceProvider = diceProvider
        self.dicesQuantity = dicesQuantity

    }
    
}
