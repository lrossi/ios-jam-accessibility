//
//  Ad.swift
//  Demo
//
//  Created by Ludovico Rossi on 16/05/2018.
//  Copyright © 2018 Schibsted Products & Technology. All rights reserved.
//

import UIKit

class Ad {
    let identifier: Int
    let title: String
    let insertionDate: Date
    let price: Int
    let location: String
    let author: String
    let description: String
    let image: UIImage

    var isFavorite: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isFavoriteKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isFavoriteKey)
        }
    }
    
    var identifierStringValue: String {
        return String(format: NSLocalizedString("Ad identifier: %d", comment: ""), identifier)
    }
    
    var insertionDateStringValue: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: insertionDate)
    }
    
    var priceStringValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencyCode = "EUR"
        return formatter.string(for: price) ?? ""
    }
    
    private static var nextIdentifier = 1
    
    private var isFavoriteKey: String {
        return "favorite-ad-status-\(identifier)"
    }
    
    init(title: String, insertionDate: Date, price: Int, location: String, author: String, description: String, image: UIImage) {
        self.identifier = Ad.nextIdentifier
        Ad.nextIdentifier += 1
        
        self.title = title
        self.insertionDate = insertionDate
        self.price = price
        self.location = location
        self.author = author
        self.description = description
        self.image = image
    }
}
