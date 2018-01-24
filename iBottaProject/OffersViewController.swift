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
    private let spacing: CGFloat = 8.0
    private let offersLoader = OffersLoader()
    
    override func loadView() {
        view = UIView(frame: .zero)
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        let safeArea = view.safeAreaLayoutGuide
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Offers"
        _setupCollectionView()
        
        let result = offersLoader.load()
        switch result {
        case .success(let offers):
            self.offers = offers
            collectionView.reloadData()
        case .error:
            print("error")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UICollectionViewDataSource
extension OffersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let offerCell = cell as? OfferCollectionViewCell {
            offerCell.populate(offers[indexPath.row])
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
        let offerViewController = OfferViewController(offer: offers[indexPath.row])

        navigationController?.pushViewController(offerViewController, animated: true)
    }
}

// MARK: - Private Helper Methods
private extension OffersViewController {
    func _setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OfferCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor.blue
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            flowLayout.minimumInteritemSpacing = spacing
            flowLayout.minimumLineSpacing = spacing
            flowLayout.estimatedItemSize = CGSize(width: 1.0, height: 1.0)
        }
    }
}
