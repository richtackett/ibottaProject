//
//  OfferCollectionViewCell.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/23/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import UIKit

final class OfferCollectionViewCell: UICollectionViewCell {
    private let backgroundCellView = UIView(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let amountLabel = UILabel(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        amountLabel.text = nil
        nameLabel.text = nil
    }
    
    func populate(_ offer: Offer) {
        
    }
}

private extension OfferCollectionViewCell {
    func _setupCell() {
        contentView.backgroundColor = UIColor.white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundCellView.backgroundColor = UIColor.lightGray
        contentView.addSubview(backgroundCellView)
        backgroundCellView.translatesAutoresizingMaskIntoConstraints = false
        backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0).isActive = true
        backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: 12.0).isActive = true
        backgroundCellView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true //Need to pass in the width
        backgroundCellView.heightAnchor.constraint(equalTo: backgroundCellView.widthAnchor, multiplier: 1.0/1.5).isActive = true
        
        amountLabel.text = "Amount"
        contentView.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.topAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: 8.0).isActive = true
        amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 12.0).isActive = true
        
        nameLabel.text = "Name"
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 3.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 12.0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24.0).isActive = true //NEEDS TO CHANGE
    }
}
