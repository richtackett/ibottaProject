//
//  OffersLoader.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/23/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import Foundation

enum Result {
    case success([Offer])
    case error(Error)
}

protocol OffersLoaderProtocol {
    func load() -> Result
}

final class OffersLoader: OffersLoaderProtocol {

    func load() -> Result {
        guard let filePath = Bundle.main.path(forResource: "Offers", ofType: "json")
            else { return .error(NSError()) }
        
        let url = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let offers = try decoder.decode([Offer].self, from: data)
            return .success(offers)
        } catch let error {
            return .error(error)
        }
    }
}
