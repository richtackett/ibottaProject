//
//  OfferCollectionViewCell.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/23/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import UIKit
import Kingfisher

protocol OfferCellDelegate: class {
    func updateCell(at indexPath: IndexPath)
}

final class OfferCollectionViewCell: UICollectionViewCell {
    private let backgroundCellView = UIView(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let favoriteButton = UIButton(frame: .zero)
    private let amountLabel = UILabel(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let style = Style()
    private let favoritesStore = OfferFavoritesStore()
    private var offer: Offer?
    
    private var contentViewWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        return floor((screenWidth / 2) - (style.horizontalInset + (style.middlePadding / 2)))
    }
    
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
    
    func populate(offer: Offer) {
        self.offer = offer
        self.offer?.isFavorite = favoritesStore.isFavorite(offerID: offer.id)
        imageView.kf.setImage(with: offer.url)
        amountLabel.text = offer.currentValue
        nameLabel.text = offer.name
        _setFavoriteDisplay(isFavorite: self.offer?.isFavorite ?? false)
    }
    
    @objc func buttonTapped(_ sender : UIButton) {
        guard var offer = offer else { return }
        
        offer.isFavorite = !offer.isFavorite
        self.offer = offer
        _setFavoriteDisplay(isFavorite: offer.isFavorite)
        favoritesStore.toggleSavingAsFavorite(offerID: offer.id)
    }
}

private extension OfferCollectionViewCell {
    func _setupCell() {
        _setupContentView()
        _addBackgroundCellView()
        _addImageView()
        _addFavoriteButton()
        _addAmountLabel()
        _addNameLabel()
    }
    
    func _setupContentView() {
        contentView.backgroundColor = UIColor.white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: contentViewWidth).isActive = true
    }
    
    func _addBackgroundCellView() {
        backgroundCellView.layer.cornerRadius = style.cornerRadius
        backgroundCellView.backgroundColor = style.backgroundColor
        contentView.addSubview(backgroundCellView)
        backgroundCellView.translatesAutoresizingMaskIntoConstraints = false
        backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: 0.0).isActive = true
        backgroundCellView.heightAnchor.constraint(equalTo: backgroundCellView.widthAnchor, multiplier: 1.0/1.5).isActive = true
    }
    
    func _addImageView() {
        imageView.contentMode = .scaleAspectFit
        backgroundCellView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 6.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: 6.0).isActive = true
        backgroundCellView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6.0).isActive = true
        backgroundCellView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6.0).isActive = true
    }
    
    func _addFavoriteButton() {
        favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        favoriteButton.backgroundColor = UIColor.white.withAlphaComponent(0.60)
        favoriteButton.layer.cornerRadius = style.cornerRadius
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        contentView.addSubview(favoriteButton)
        favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 0.0).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    func _addAmountLabel() {
        amountLabel.font = style.boldFont
        amountLabel.textColor = style.textColor
        contentView.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.topAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: 8.0).isActive = true
        amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 0.0).isActive = true
    }
    
    func _addNameLabel() {
        nameLabel.font = style.regularFont
        nameLabel.textColor = style.textColor
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 3.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0.0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0.0).isActive = true
    }
    
    func _setFavoriteDisplay(isFavorite: Bool) {
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "solidHeart"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
}
