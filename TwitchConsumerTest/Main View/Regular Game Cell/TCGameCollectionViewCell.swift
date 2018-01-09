//
//  TCGameCollectionViewCell.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TCGameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewCountLabel: UILabel!
    
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

extension TCGameCollectionViewCell: SelfDesignableCell {

    func setup(model: Game?) {
        DispatchQueue.main.async {
            
            // setting view count label
            if let viewCount = model?.viewers {
                self.viewCountLabel.text = String(describing: viewCount)
            }
            
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
