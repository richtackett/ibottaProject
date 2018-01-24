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
    private let backgroundView = UIView(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let amountLabel = UILabel(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let descriptionLabel = UILabel(frame: .zero)
    
    init(offer: Offer) {
        self.offer = offer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        
        let safeArea = view.safeAreaLayoutGuide
        
        backgroundView.backgroundColor = UIColor.lightGray
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24.0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12.0).isActive = true
        safeArea.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 12.0).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 1.0/1.5).isActive = true
        
        imageView.contentMode = .scaleAspectFit
        backgroundView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 6.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 6.0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6.0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6.0).isActive = true
        
        amountLabel.numberOfLines = 0
        view.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 8.0).isActive = true
        amountLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12.0).isActive = true
        safeArea.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 12.0).isActive = true
        
        nameLabel.numberOfLines = 0
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 3.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12.0).isActive = true
        safeArea.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 12.0).isActive = true
        
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3.0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12.0).isActive = true
        safeArea.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 12.0).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Offer Detail"
        _populate()
    }
}

// MARK: - Private Helper Methods
private extension OfferViewController {
    func _populate() {
        imageView.kf.setImage(with: offer.url)
        amountLabel.text = offer.currentValue
        nameLabel.text = offer.name
        descriptionLabel.text = offer.description
    }
}
