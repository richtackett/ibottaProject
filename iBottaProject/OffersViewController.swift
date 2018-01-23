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
        
        let guide = view.safeAreaLayoutGuide
        collectionView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.blue
        
        let result = offersLoader.load()
        
        switch result {
        case .success:
            print("success")
        case .error:
            print("error")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
