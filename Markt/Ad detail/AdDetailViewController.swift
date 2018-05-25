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
        
        contactLabel.isAccessibilityElement = false
        contactView.isAccessibilityElement = true
        contactView.accessibilityLabel = contactLabel.text
        contactView.accessibilityTraits |= UIAccessibilityTraitButton
        
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = NSLocalizedString("1 image", comment: "")
    }
    
    private func setupLabels() {
        titleLabel.adjustsFontForContentSizeCategory = true
        priceLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.adjustsFontForContentSizeCategory = true
        infoLabel.adjustsFontForContentSizeCategory = true
        authorLabel.adjustsFontForContentSizeCategory = true
        identifierLabel.adjustsFontForContentSizeCategory = true
        contactLabel.adjustsFontForContentSizeCategory = true
        
        let headlineFont = UIFont.boldSystemFont(ofSize: 17)
        let headlineFontMetrics = UIFontMetrics(forTextStyle: .headline)
        let headlineScaledFont = headlineFontMetrics.scaledFont(for: headlineFont)
        
        titleLabel.font = headlineScaledFont
        priceLabel.font = headlineScaledFont
        contactLabel.font = headlineScaledFont
        
        let caption1Font = UIFont.systemFont(ofSize: 15)
        let caption1FontMetrics = UIFontMetrics(forTextStyle: .caption1)
        let captionScaledFont = caption1FontMetrics.scaledFont(for: caption1Font)
        
        infoLabel.font = captionScaledFont
        authorLabel.font = captionScaledFont
        
        let bodyFont = UIFont.systemFont(ofSize: 17)
        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let bodyScaledFont = bodyFontMetrics.scaledFont(for: bodyFont)
        
        descriptionLabel.font = bodyScaledFont
        
        let caption2Font = UIFont.systemFont(ofSize: 13)
        let caption2FontMetrics = UIFontMetrics(forTextStyle: .caption2)
        identifierLabel.font = caption2FontMetrics.scaledFont(for: caption2Font)
    }
    
    override func accessibilityPerformMagicTap() -> Bool {
        openContact()
        return true
    }
    
    func updateFavoriteStatusButton() {
        guard let ad = ad else {
            return
        }
        
        let image = ad.isFavorite ? #imageLiteral(resourceName: "filled-small-heart") : #imageLiteral(resourceName: "small-heart")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(toggleFavoriteStatus))
        
        if ad.isFavorite {
            button.accessibilityLabel = NSLocalizedString("Remove from favorites", comment: "")
        } else {
            button.accessibilityLabel = NSLocalizedString("Add to favorites", comment: "")
        }
        
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
