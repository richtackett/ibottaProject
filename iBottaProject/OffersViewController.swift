//
//  OffersViewController.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/23/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import UIKit

final class OffersViewController: UIViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let cellIdentifier = "OfferCell"
    private var offers = [Offer]()
    private let offersService = OffersService()
    
    private let style = Style()
    
    override func loadView() {
        _addView()
        _addCollectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Offers"
        _setupCollectionView()
        _loadOffers()
    }
}

// MARK: - UICollectionViewDataSource
extension OffersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let offerCell = cell as? OfferCollectionViewCell {
            offerCell.populate(offer: offers[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
}

// MARK: - UICollectionViewDelegate
extension OffersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let offerViewController = OfferViewController(offer: offers[indexPath.row], indexPath: indexPath)
        offerViewController.delegate = self
        navigationController?.pushViewController(offerViewController, animated: true)
    }
}

// MARK: - OfferCellDelegate
extension OffersViewController: OfferCellDelegate {
    func updateCell(at indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - Private Helper Methods
private extension OffersViewController {
    func _addView() {
        view = UIView(frame: .zero)
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func _addCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        safeArea.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        safeArea.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
    }
    
    func _setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OfferCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor.white
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = UIEdgeInsets(top: style.verticalInset, left: style.horizontalInset, bottom: style.verticalInset, right: style.horizontalInset)
            flowLayout.minimumInteritemSpacing = style.middlePadding
            flowLayout.minimumLineSpacing = style.verticalInset
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }
    
    func _loadOffers() {
        offersService.load {[weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let offers):
                    self?._handleSuccess(offers: offers)
                case .error:
                    self?._handleError()
                }
            }
        }
    }
    
    func _handleSuccess(offers: [Offer]) {
        self.offers = offers
        collectionView.reloadData()
    }
    
    func _handleError() {
        let alert = UIAlertController(title: "Error", message: "Unable to load Offers", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
