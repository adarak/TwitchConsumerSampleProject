//
//  UIImageView+Extensions.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/8/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func set(image: UIImage) {
        DispatchQueue.main.async {
            let transition = CATransition()
            transition.type = kCATransitionFade
            transition.duration = 0.2
            self.layer.add(transition, forKey: "imageFade")
            self.image = image
        }
    }
}
