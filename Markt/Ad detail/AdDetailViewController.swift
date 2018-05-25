//
//  AdDetailViewController.swift
//  Demo
//
//  Created by Ludovico Rossi on 19/05/2018.
//  Copyright © 2018 Schibsted Products & Technology. All rights reserved.
//

import UIKit

class AdDetailViewController: UIViewController {
    var ad: Ad?
    
    private let contactSegue = "contact"
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var identifierLabel: UILabel!
    @IBOutlet private var contactLabel: UILabel!
    @IBOutlet private var contactView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        
        imageView.image = ad?.image
        titleLabel.text = ad?.title
        priceLabel.text = ad?.priceStringValue
        if let location = ad?.location, let insertionDate = ad?.insertionDateStringValue {
            infoLabel.text = location + ", " + insertionDate
        }
        if let author = ad?.author {
            authorLabel.text = String(format: NSLocalizedString("Inserted by %@", comment: ""), author)
        }
        descriptionLabel.text = ad?.description
        identifierLabel.text = ad?.identifierStringValue
        contactLabel.text = NSLocalizedString("Contact", comment: "")
        updateFavoriteStatusButton()
    }
    
    private func setupLabels() {
        let headlineFont = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.font = headlineFont
        priceLabel.font = headlineFont
        contactLabel.font = headlineFont
        
        let caption1Font = UIFont.systemFont(ofSize: 15)
        infoLabel.font = caption1Font
        authorLabel.font = caption1Font
        
        let bodyFont = UIFont.systemFont(ofSize: 17)
        descriptionLabel.font = bodyFont
        
        let caption2Font = UIFont.systemFont(ofSize: 13)
        identifierLabel.font = caption2Font
    }
    
    func updateFavoriteStatusButton() {
        guard let ad = ad else {
            return
        }
        
        let image = ad.isFavorite ? #imageLiteral(resourceName: "filled-small-heart") : #imageLiteral(resourceName: "small-heart")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(toggleFavoriteStatus))
        navigationItem.setRightBarButton(button, animated: true)
    }
    
    @objc private func toggleFavoriteStatus() {
        guard let ad = ad else {
            return
        }
        
        ad.isFavorite = !ad.isFavorite
        updateFavoriteStatusButton()
    }
    
    @IBAction private func contact(recognizer: UITapGestureRecognizer) {
        openContact()
    }
    
    private func openContact() {
        performSegue(withIdentifier: contactSegue, sender: self)
    }
    
    @IBAction private func unwindToAdDetail(segue: UIStoryboardSegue) {}
}
