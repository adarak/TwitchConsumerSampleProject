//
//  TCTopFeaturedCollectionViewCell.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

class TCTopFeaturedCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
}

extension TCTopFeaturedCollectionViewCell: SelfSizableCell {
    static func sizeFor(screenWidth: CGFloat) -> CGSize {
        let coverImageWidthRatio: CGFloat = 0.35
        let coverImageAspectRatio: CGFloat = 0.66667
        let bottomInsetSize: CGFloat = 14.0
        let sideInsetSpace: CGFloat = 16.0 * 2
        
        let cellWidth = screenWidth - sideInsetSpace
        let coverImageWidth = coverImageWidthRatio * cellWidth
        let coverImageHeight = coverImageWidth / coverImageAspectRatio
        
        let cellHeight = coverImageHeight + bottomInsetSize
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension TCTopFeaturedCollectionViewCell: SelfPopulatingCell {
    
    func setup(model: GameDetails) {
        
    }
}
