//
//  Favorite+CoreDataProperties.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/24/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var offerID: String?

}
