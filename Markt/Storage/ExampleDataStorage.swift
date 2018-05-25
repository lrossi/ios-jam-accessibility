//
//  ExampleDataStorage.swift
//  Demo
//
//  Created by Ludovico Rossi on 16/05/2018.
//  Copyright © 2018 Schibsted Products & Technology. All rights reserved.
//

import Foundation

class ExampleDataStorage: Storage {
    private static let ads = [
        Ad(
            title: "Bycicle",
            insertionDate: Date(timeIntervalSinceReferenceDate: 545170537),
            price: 350,
            location: "Oslo",
            author: "Rider",
            description: "Very nice bicycle.",
            image: #imageLiteral(resourceName: "bicycle")
        ),
        Ad(
            title: "Mug",
            insertionDate: Date(timeIntervalSinceReferenceDate: 545170537),
            price: 9,
            location: "Oslo",
            author: "Tea lover",
            description: "Very nice mug.",
            image: #imageLiteral(resourceName: "mug")
        ),
        Ad(
            title: "Gameboy Color",
            insertionDate: Date(timeIntervalSinceReferenceDate: 545170537),
            price: 69,
            location: "Oslo",
            author: "Daisy",
            description: "Fully functional.",
            image: #imageLiteral(resourceName: "gameboy")
        ),
        Ad(
            title: "Original Fiat 500",
            insertionDate: Date(timeIntervalSinceReferenceDate: 545170537),
            price: 3500,
            location: "Oslo",
            author: "Virginia",
            description: "Very nice car.",
            image: #imageLiteral(resourceName: "car")
        ),
        Ad(
            title: "Nintendo Switch",
            insertionDate: Date(timeIntervalSinceReferenceDate: 545170537),
            price: 300,
            location: "Oslo",
            author: "Mario",
            description: "Very nice console.",
            image: #imageLiteral(resourceName: "switch")
        ),
        Ad(
            title: "Spiderman costume",
            insertionDate: Date(timeIntervalSinceReferenceDate: 545170537),
            price: 35,
            location: "Oslo",
            author: "Peter",
            description: "Very nice costume.",
            image: #imageLiteral(resourceName: "spiderman")
        ),
        Ad(
            title: "PS4",
            insertionDate: Date(timeIntervalSinceReferenceDate: 545170537),
            price: 200,
            location: "Oslo",
            author: "Player One",
            description: "PS4 with DualShock controller and original cables.",
            image: #imageLiteral(resourceName: "ps4")
        )
    ]
    
    private var ads: [Ad] = ExampleDataStorage.ads
    
    private(set) var isFiltering = false
    
    var numberOfAds: Int {
        return ads.count
    }
    
    var numberOfFavoriteAds: Int {
        let favoriteAds = ads.filter { $0.isFavorite }
        return favoriteAds.count
    }
    
    func ad(at index: Int) -> Ad {
        return ads[index]
    }
    
    func filter(for query: String) {
        if query.isEmpty {
            ads = ExampleDataStorage.ads
            isFiltering = false
            return
        }
        
        let query = query.lowercased()
        ads = ExampleDataStorage.ads.filter {
            return $0.title.lowercased().contains(query) || $0.description.lowercased().contains(query)
        }
        
        isFiltering = true
    }
}
