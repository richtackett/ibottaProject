//
//  OfferFavoritesStore.swift
//  iBottaProject
//
//  Created by RICHARD TACKETT on 1/24/18.
//  Copyright © 2018 RICHARD TACKETT. All rights reserved.
//

import Foundation
import CoreData

final class OfferFavoritesStore {
    private let managedContext = CoreDataStack.shared.managedContext
    private let favoritesFetch: NSFetchRequest<Favorite> = Favorite.fetchRequest()
    
    func isFavorite(offerID: String) -> Bool {
        favoritesFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Favorite.offerID), offerID)
        do {
            let results = try managedContext.fetch(favoritesFetch)
            if results.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return false
        }
    }
    
    func toggleSavingAsFavorite(offerID: String) {
        favoritesFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Favorite.offerID), offerID)
        do {
            let results = try managedContext.fetch(favoritesFetch)
            //Remove favorite
            if results.count > 0 {
                if let favorite = results.first {
                    managedContext.delete(favorite)
                }
            } else {
                //Add favorite
                let favorite = Favorite(context: managedContext)
                favorite.offerID = offerID
            }
            
            try managedContext.save()
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
}
