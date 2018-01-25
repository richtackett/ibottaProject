//
//  OfferViewController.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/23/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import UIKit
import Kingfisher

final class OfferViewController: UIViewController {
    private var offer: Offer
    private let indexPath: IndexPath
    private let backgroundView = UIView(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let favoriteButton = UIButton(frame: .zero)
    private let amountLabel = UILabel(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let descriptionLabel = UILabel(frame: .zero)
    private let style = Style()
    private let favoritesStore = OfferFavoritesStore()
    weak var delegate: OfferCellDelegate?
    
    init(offer: Offer, indexPath: IndexPath) {
        self.offer = offer
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        _addBackgroundView()
        _addImageView()
        _addFavoriteButton()
        _addAmountLabel()
        _addNameLabel()
        _addDescriptionLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Offer Detail"
        _populate()
    }
    
    @objc func buttonTapped(_ sender : UIButton) {
        offer.isFavorite = !offer.isFavorite
        _setFavoriteDisplay(isFavorite: offer.isFavorite)
        favoritesStore.toggleSavingAsFavorite(offerID: offer.id)
        delegate?.updateCell(at: indexPath)
    }
}

// MARK: - Private Helper Methods
private extension OfferViewController {
    func _addBackgroundView() {
        backgroundView.layer.cornerRadius = style.cornerRadius
        backgroundView.backgroundColor = style.backgroundColor
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24.0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12.0).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 12.0).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 1.0/1.5).isActive = true
    }
    
    func _addImageView() {
        imageView.contentMode = .scaleAspectFit
        backgroundView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 6.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 6.0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6.0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6.0).isActive = true
    }
    
    func _addFavoriteButton() {
        favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        favoriteButton.backgroundColor = UIColor.white.withAlphaComponent(0.60)
        favoriteButton.layer.cornerRadius = style.cornerRadius
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        backgroundView.addSubview(favoriteButton)
        favoriteButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 6.0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 6.0).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    func _addAmountLabel() {
        amountLabel.numberOfLines = 0
        amountLabel.font = style.amountFont?.withSize(16.0)
        amountLabel.textColor = style.textColor
        view.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 8.0).isActive = true
        amountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12.0).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 12.0).isActive = true
    }
    
    func _addNameLabel() {
        nameLabel.numberOfLines = 0
        nameLabel.font = style.nameFont?.withSize(14.0)
        nameLabel.textColor = style.textColor
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 3.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12.0).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 12.0).isActive = true
    }
    
    func _addDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = style.descriptionFont?.withSize(12.0)
        descriptionLabel.textColor = style.textColor
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3.0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12.0).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 12.0).isActive = true
    }
    
    func _populate() {
        offer.isFavorite = favoritesStore.isFavorite(offerID: offer.id)
        _setFavoriteDisplay(isFavorite: offer.isFavorite)
        imageView.kf.setImage(with: offer.url)
        amountLabel.text = offer.currentValue
        nameLabel.text = offer.name
        descriptionLabel.text = offer.description
    }
    
    func _setFavoriteDisplay(isFavorite: Bool) {
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "solidHeart"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
}
