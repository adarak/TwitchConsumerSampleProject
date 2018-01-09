//
//  TCMainViewController.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

class TCMainViewController: UIViewController {

    @IBOutlet weak var collectionView: TCMainCollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Artificial Delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            let mainService = TCMainViewService(twitchAPISession: TCDataSession.shared)
            mainService.getTopGames().then(on: .main) { [weak self] (topLevelResponse) -> Void in
                self?.activityIndicator.stopAnimating()
                self?.collectionView.setup(topGames: topLevelResponse)
                self?.setBackgroundImage(topGames: topLevelResponse)
                UIView.animate(withDuration: 0.25, animations: {
                    self?.collectionView.alpha = 1
                })
            }.catch { (error) in
                print(error)
            }
        })
    }
    
    private func setBackgroundImage(topGames: TopGames) {
        DispatchQueue.main.async {
            if !topGames.games.isEmpty {
                let firstGame = topGames.games.first
                let mainService = TCMainViewService.init(twitchAPISession: TCDataSession.shared)
                if let imageUrl = firstGame?.gameDetails.box.large {
                    mainService.getImage(urlString: imageUrl).then(execute: { [weak self] image -> Void in
                        self?.backgroundImage.set(image: image)
                    }).catch(execute: { (error) in
                        print(error)
                    })
                }
            }
        }
    }
}
