//
//  OffersLoader.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/24/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import Foundation

protocol OffersLoaderProtocol {
    func load(completion: @escaping (Result<Data>) -> Void)
}

final class OffersLoader: OffersLoaderProtocol {
    func load(completion: @escaping (Result<Data>) -> Void) {
        guard let filePath = Bundle.main.path(forResource: "Offers", ofType: "json") else {
            completion(.error(NSError(domain: "OffersLoader", code: 200, userInfo: nil)))
            return
        }
        
        let url = URL(fileURLWithPath: filePath)
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: url)
                completion(.success(data))
            } catch let error {
                completion(.error(error))
            }
        }
    }
}
