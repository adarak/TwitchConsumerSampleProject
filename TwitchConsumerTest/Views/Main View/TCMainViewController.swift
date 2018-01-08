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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitchAPI.getTopGames().then(on: .main) { [weak self] topLevelResponse -> Void in
            self?.collectionView.setup(topGamesResponse: topLevelResponse)
        } .catch { (error) in
            print(error)
        }
    }
}
