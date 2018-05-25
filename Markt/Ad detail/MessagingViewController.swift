//
//  MessagingViewController.swift
//  Markt
//
//  Created by Ludovico Rossi on 24/05/2018.
//  Copyright © 2018 Schibsted Products & Technology. All rights reserved.
//

import UIKit

class MessagingViewController: UIViewController {
    private let dismissSegue = "dismiss"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Send message", comment: "")
    }
}
