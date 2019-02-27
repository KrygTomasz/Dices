//
//  DiceRollCollectionViewCell.swift
//  Dices
//
//  Created by Krygu on 27/02/2019.
//  Copyright © 2019 Krygu. All rights reserved.
//

import UIKit

class DiceRollCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let margin: CGFloat = 8
        static let textSize: CGFloat = 54
        static let borderSize: CGFloat = 1
        static let radius: CGFloat = 16
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor, constant: Constants.margin).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.margin).isActive = true
        view.layer.borderWidth = Constants.borderSize
        view.layer.borderColor = Theme.main.colors.secondaryColor.cgColor
        view.layer.cornerRadius = Constants.radius
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.margin).isActive = true
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.margin).isActive = true
        label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.margin).isActive = true
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.margin).isActive = true
        label.textColor = Theme.main.colors.primaryTextColor
        label.font = UIFont.systemFont(ofSize: Constants.textSize)
        label.textAlignment = .center
        return label
    }()
    
    override var reuseIdentifier: String? {
        return String(describing: DiceRollCollectionViewCell.self)
    }

}
