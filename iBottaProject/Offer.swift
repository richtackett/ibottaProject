//
//  Offer.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/23/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import Foundation

struct Offer: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case description
        case terms
        case currentValue = "current_value"
    }
    
    let id: String
    let url: URL?
    let name: String
    let description: String
    let terms: String
    let currentValue: String
    var isFavorite = false
}
