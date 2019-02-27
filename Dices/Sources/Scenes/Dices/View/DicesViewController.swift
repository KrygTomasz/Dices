//
//  DicesViewController.swift
//  Dices
//
//  Created by Krygu on 27/02/2019.
//  Copyright © 2019 Krygu. All rights reserved.
//

import UIKit

private enum Constants {
    static let textSize: CGFloat = 30
}

class DicesViewController: UIViewController {

    @IBOutlet weak var diceTypeLabel: UILabel!
    @IBOutlet weak var diceTypeField: UITextField!
    @IBOutlet weak var diceQuantityLabel: UILabel!
    @IBOutlet weak var diceQuantityField: UITextField!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

//MARK: - setup UI
extension DicesViewController {
    
    private func setupUI() {
        title = "Dices"
        view.backgroundColor = Theme.main.colors.primaryColor
        setupLabels()
        setupTextFields()
        setupButtons()
    }
    
    private func setupLabels() {
        diceTypeLabel.text = "Dice type"
        diceTypeLabel.textColor = Theme.main.colors.primaryTextColor
        diceQuantityLabel.text = "Dice quantity"
        diceQuantityLabel.textColor = Theme.main.colors.primaryTextColor
    }
    
    private func setupTextFields() {
        diceTypeField.defaultSetup()
        diceQuantityField.defaultSetup()
    }
    
    private func setupButtons() {
        rollButton.setTitle("Roll!", for: .normal)
        rollButton.setTitleColor(Theme.main.colors.primaryTextColor, for: .normal)
        rollButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.textSize)
    }
    
}

private extension UITextField {
    
    func defaultSetup() {
        borderStyle = .none
        textColor = Theme.main.colors.primaryTextColor
        font = UIFont.systemFont(ofSize: Constants.textSize)
        textAlignment = .right
        returnKeyType = .done
    }
    
}
