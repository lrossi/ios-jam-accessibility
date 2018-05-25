//
//  FavoriteAdsViewController.swift
//  Demo
//
//  Created by Ludovico Rossi on 19/05/2018.
//  Copyright © 2018 Schibsted Products & Technology. All rights reserved.
//

import UIKit

class FavoriteAdsViewController: UIViewController {
    @IBOutlet private var textLabel: UILabel!
    
    private let storage = ExampleDataStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Favorite ads", comment: "")
        
        textLabel.adjustsFontForContentSizeCategory = true
        
        let bodyFont = UIFont.systemFont(ofSize: 16)
        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        textLabel.font = bodyFontMetrics.scaledFont(for: bodyFont)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch storage.numberOfFavoriteAds {
        case 0:
            textLabel.text = NSLocalizedString("In the “Search” tab,\nadd some ads to your favorite ones!", comment: "")
        case 1:
            textLabel.text = NSLocalizedString("You have 1 favorite ad.", comment: "")
        case let n:
            textLabel.text = String(format: NSLocalizedString("You have %d favorite ads.", comment: ""), n)
        }
    }
}
