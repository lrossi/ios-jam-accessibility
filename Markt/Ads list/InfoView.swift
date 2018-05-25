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
        
        textLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    func confugure(for text: String) {
        textLabel.text = text
    }
}
