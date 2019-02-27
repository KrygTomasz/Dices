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

class DicesViewController: UIViewController {

    private enum Constants {
        static let textSize: CGFloat = 30
        static let topInset: CGFloat = 16
    }
    
    @IBOutlet weak var diceTypeLabel: UILabel!
    @IBOutlet weak var diceTypeField: UITextField!
    @IBOutlet weak var diceQuantityLabel: UILabel!
    @IBOutlet weak var diceQuantityField: UITextField!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var diceTypePicker: UIPickerView = {
        return UIPickerView()
    }()
    private lazy var diceQuantityPicker: UIPickerView = {
        return UIPickerView()
    }()
    
    private let viewModel: DicesViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    private let diceRollCellId = String(describing: DiceRollCollectionViewCell.self)
    
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
                self?.diceTypeField.resignFirstResponder()
            })
            .map { [unowned self] in
                self.viewModel.diceProvider.dices[$0.row]}
            .bind(to: self.viewModel.selectedDice)
            .disposed(by: disposeBag)
        
        diceQuantityPicker.rx.itemSelected
            .do(onNext: { [weak self] _ in
                self?.diceQuantityField.resignFirstResponder()
            })
            .map { [unowned self] in
                self.viewModel.dicesQuantityArray[$0.row] }
            .bind(to: viewModel.selectedQuantity)
            .disposed(by: disposeBag)
        
        viewModel.rollResults
            .bind(to: collectionView.rx.items(cellIdentifier: diceRollCellId, cellType: DiceRollCollectionViewCell.self)) { row, data, cell in
                cell.titleLabel.text = "\(data)"
            }
        .disposed(by: disposeBag)
    }
    
}

//MARK: - setup UI
extension DicesViewController {
    
    private func setupUI() {
        title = "Dices"
        view.backgroundColor = Theme.main.colors.primaryColor
        setupCollectionView()
        setupLabels()
        setupTextFields()
        setupSeparator()
    }
    
    private func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: Constants.topInset, left: 0, bottom: 0, right: 0)
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(DiceRollCollectionViewCell.self, forCellWithReuseIdentifier: diceRollCellId)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupLabels() {
        diceTypeLabel.text = "Type"
        diceTypeLabel.textColor = Theme.main.colors.primaryTextColor
        diceTypeLabel.isUserInteractionEnabled = true
        let diceTypeGesture = UITapGestureRecognizer(target: self, action: #selector(focusDiceTypeField))
        diceTypeLabel.addGestureRecognizer(diceTypeGesture)

        diceQuantityLabel.text = "Quantity"
        diceQuantityLabel.textColor = Theme.main.colors.primaryTextColor
        diceQuantityLabel.isUserInteractionEnabled = true
        let diceQuantityGesture = UITapGestureRecognizer(target: self, action: #selector(focusDiceQuantityField))
        diceQuantityLabel.addGestureRecognizer(diceQuantityGesture)
    }
    
    @objc private func focusDiceTypeField() {
        diceTypeField.becomeFirstResponder()
    }
    
    @objc private func focusDiceQuantityField() {
        diceQuantityField.becomeFirstResponder()
    }
    
    private func setupTextFields() {
        setupTextField(diceTypeField)
        setupTextField(diceQuantityField)
        diceTypeField.inputView = diceTypePicker
        diceQuantityField.inputView = diceQuantityPicker
    }
    
    private func setupTextField(_ textField: UITextField) {
        textField.borderStyle = .none
        textField.textColor = Theme.main.colors.primaryTextColor
        textField.tintColor = Theme.main.colors.primaryTextColor
        textField.font = UIFont.systemFont(ofSize: Constants.textSize)
        textField.textAlignment = .right
        textField.returnKeyType = .done
    }
    
    private func setupSeparator() {
        separatorView.backgroundColor = Theme.main.colors.secondaryColor
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DicesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
