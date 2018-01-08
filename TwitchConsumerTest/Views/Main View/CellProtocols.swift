//
//  SelfSizable.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

protocol SelfSizableCell {
    static func sizeFor(screenWidth: CGFloat) -> CGSize
}

protocol SelfPopulatingCell {
    func setup(model: GameDetails)
}
