//
//  TCGameCollectionViewCell.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

class TCGameCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
}

extension TCGameCollectionViewCell: SelfSizableCell {
    static func sizeFor(screenWidth: CGFloat) -> CGSize {
        let coverImageAspectRatio: CGFloat = 1.5
        let columns: CGFloat = 3.0
        let interItemSpace: CGFloat = 8.0 * (columns - 1.0)
        let sideInsetSpace: CGFloat = 16.0 * 2
        let bottomSpace: CGFloat = 14.0
        
        let screenWidthWithoutSpacing = screenWidth - sideInsetSpace - interItemSpace
        let cellWidth = screenWidthWithoutSpacing / columns
        let cellHeight = (cellWidth * coverImageAspectRatio) + bottomSpace
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
