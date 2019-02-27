//
//  DicesViewController.swift
//  Dices
//
//  Created by Krygu on 27/02/2019.
//  Copyright © 2019 Krygu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

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
    
    private lazy var diceTypePicker: UIPickerView = {
        return UIPickerView()
    }()
    private lazy var diceQuantityPicker: UIPickerView = {
        return UIPickerView()
    }()
    
    private let viewModel: DicesViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(viewModel: DicesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DicesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupUI()
    }

}

//MARK: - setup binding
extension DicesViewController {
    private func bindUI() {
        bindInput()
        bindOutput()
    }
    
    private func bindInput() {
        Observable.of(viewModel.diceProvider.dices)
        .bind(to: diceTypePicker.rx.itemTitles) { (_, element) in
            return element.label
        }
        .disposed(by: disposeBag)
        
        Observable.of(viewModel.dicesQuantityArray)
        .bind(to: diceQuantityPicker.rx.itemTitles) { (_, element) in
            return "\(element)"
        }
        .disposed(by: disposeBag)
        
        viewModel.selectedDice.asObservable()
            .map { $0.label }
            .bind(to: diceTypeField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.selectedQuantity.asObservable()
            .map { "\($0)" }
            .bind(to: diceQuantityField.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        diceTypePicker.rx.itemSelected
            .do(onNext: { [weak self] _ in
                self?.diceTypeField.endEditing(true)
            })
            .map { [unowned self] in
                self.viewModel.diceProvider.dices[$0.row]}
            .bind(to: self.viewModel.selectedDice)
            .disposed(by: disposeBag)
        
        diceQuantityPicker.rx.itemSelected
            .do(onNext: { [weak self] _ in
                self?.diceQuantityField.endEditing(true)
            })
            .map { [unowned self] in
                self.viewModel.dicesQuantityArray[$0.row] }
            .bind(to: viewModel.selectedQuantity)
            .disposed(by: disposeBag)
        
        let rollTrigger = Observable.combineLatest(
                rollButton.rx.tap,
                viewModel.selectedDice.asObservable(),
                viewModel.selectedQuantity.asObservable())

        rollTrigger
            .asDriver(onErrorJustReturn: ((), Dice(sides: 6), 1))
            .drive(onNext: { (_, dice, quantity) in
                print(quantity)
            })
            .disposed(by: disposeBag)
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
        diceTypeField.inputView = diceTypePicker
        diceQuantityField.defaultSetup()
        diceQuantityField.inputView = diceQuantityPicker
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
