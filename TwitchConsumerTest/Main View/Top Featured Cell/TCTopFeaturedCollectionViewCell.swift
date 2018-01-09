//
//  TCTopFeaturedCollectionViewCell.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

class TCTopFeaturedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var streamLabel: UILabel!
    @IBOutlet weak var viewersLabel: UILabel!

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

extension TCTopFeaturedCollectionViewCell: SelfDesignableCell {
    
    func setup(model: Game?) {
        DispatchQueue.main.async {
            
            // setting view count label
            if let viewCount = model?.viewers {
                self.viewersLabel.text = String(describing: viewCount)
            }
            
            // setting stream count label
            if let streamCount = model?.channels {
                self.streamLabel.text = String(describing: streamCount)
            }
            
            // Setting Game Title
            self.titleLabel.text = model?.gameDetails.name ?? "Title"
            
            // setting image
            if let imageURL = model?.gameDetails.box.large {
                let mainViewService = TCMainViewService.init(twitchAPISession: TCDataSession.shared)
                mainViewService.getImage(urlString: imageURL).then(execute: { image -> Void in
                    self.imageView.set(image: image)
                }).catch(execute: { (error) in
                    print(error)
                })
            }
        }
    }
}
