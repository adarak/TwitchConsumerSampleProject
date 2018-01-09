//
//  TCNavigationViewController.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

class TCNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar appearance is managed view to view
        setNavigationBarHidden(true, animated: false)
        
        // Setting the initial view controller
        let mainViewController = TCMainViewController()
        self.viewControllers = [mainViewController]
    }
}
