//
//  OffersLoader.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/23/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}

final class OffersService {
    private let fileLoader: FileLoaderProtocol
    private let decoder = JSONDecoder()
    
    init(fileLoader: FileLoaderProtocol) {
        self.fileLoader = fileLoader
    }
    
    convenience init() {
        self.init(fileLoader: FileLoader())
    }
    
    func load(completion: @escaping (Result<[Offer]>) -> Void) {
        fileLoader.load {[unowned self] (result) in
            switch result {
            case .success(let data):
                self._decodeData(data: data, completion: completion)
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    func _decodeData(data: Data, completion: @escaping (Result<[Offer]>) -> Void) {
        do {
            let offers = try decoder.decode([Offer].self, from: data)
            completion(.success(offers))
        } catch let error {
            completion(.error(error))
        }
    }
}
