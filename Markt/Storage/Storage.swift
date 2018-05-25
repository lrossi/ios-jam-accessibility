//
//  Storage.swift
//  Demo
//
//  Created by Ludovico Rossi on 16/05/2018.
//  Copyright © 2018 Schibsted Products & Technology. All rights reserved.
//

import Foundation

protocol Storage {
    var isFiltering: Bool { get }
    var numberOfAds: Int { get }
    var numberOfFavoriteAds: Int { get }
    
    func ad(at index: Int) -> Ad
    func filter(for query: String)
}
