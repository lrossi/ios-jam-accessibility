//
//  InfoView.swift
//  Demo
//
//  Created by Ludovico Rossi on 19/05/2018.
//  Copyright © 2018 Schibsted Products & Technology. All rights reserved.
//

import UIKit

class InfoView: UICollectionReusableView {
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var transparencyView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateTransparency()
    }
    
    @objc private func updateTransparency() {
        if UIAccessibilityIsReduceTransparencyEnabled() {
            transparencyView.isHidden = true
            backgroundColor = UIColor(white: 0.94, alpha: 1)
        } else {
            transparencyView.isHidden = false
            backgroundColor = UIColor(white: 0.34, alpha: 0.23)
        }
    }
    
    func confugure(for text: String) {
        textLabel.text = text
    }
}
