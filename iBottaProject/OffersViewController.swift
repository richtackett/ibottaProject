//
//  OffersViewController.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/23/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import UIKit

class OffersViewController: UIViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func loadView() {
        view = UIView(frame: .zero)
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        view.backgroundColor = UIColor.red
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor), collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)])
        
        let guide = view.safeAreaLayoutGuide
        collectionView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0).isActive = true
        guide.bottomAnchor.constraintEqualToSystemSpacingBelow(collectionView.bottomAnchor, multiplier: 1.0).isActive = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
