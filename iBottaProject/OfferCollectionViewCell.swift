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
        
        backgroundCellView.translatesAutoresizingMaskIntoConstraints = false
        backgroundCellView.backgroundColor = UIColor.lightGray
        contentView.addSubview(backgroundCellView)
        
        backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0).isActive = true
        backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: 12.0).isActive = true
        

        backgroundCellView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true //Need to pass in the width
        
        backgroundCellView.heightAnchor.constraint(equalTo: backgroundCellView.widthAnchor, multiplier: 1.0/1.5).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: 24.0).isActive = true //NEEDS TO CHANGE
        
    }
}
