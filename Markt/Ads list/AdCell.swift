//
//  AdCell.swift
//  Demo
//
//  Created by Ludovico Rossi on 16/05/2018.
//  Copyright © 2018 Schibsted Products & Technology. All rights reserved.
//

import UIKit

class AdCell: UICollectionViewCell {
    var didToggleFavoriteStatus: (() -> Void)?
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var toggleFavoriteStatusButton: UIButton!
    @IBOutlet private var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLabels()
        
        let cornerRadius: CGFloat = 4
        
        imageView.layer.cornerRadius = cornerRadius
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor(white: 0.9, alpha: 0.7).cgColor
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = cornerRadius
    }
    
    func setWidth(_ width: CGFloat) {
        widthConstraint.constant = width
    }
    
    private func setupLabels() {
        let calloutFont = UIFont.systemFont(ofSize: 12)
        titleLabel.font = calloutFont
        priceLabel.font = calloutFont
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        didToggleFavoriteStatus = nil
        
        sizeToFit()
    }
    
    func configure(for ad: Ad) {
        imageView.image = ad.image
        titleLabel.text = ad.title
        priceLabel.text = ad.priceStringValue
        toggleFavoriteStatusButton.isSelected = ad.isFavorite
    }
    
    @IBAction private func toggleFavoriteStatus() {
        toggleFavoriteStatusButton.isSelected = !toggleFavoriteStatusButton.isSelected
        didToggleFavoriteStatus?()
    }
}
