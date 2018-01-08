//
//  TCMainCollectionView.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

class TCMainCollectionView: UICollectionView {
    
    var topLevelResponse: TopLevelResponse?
    var viewsWereLaidOut = false
    
    enum Constants {
        static let featuredCellReuseID = "TCTopFeaturedCollectionViewCell"
        static let regularGameCellReuseID = "TCGameCollectionViewCell"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !viewsWereLaidOut {
            viewsWereLaidOut = true
            
            self.registerCells()
            
            DispatchQueue.main.async {
                self.delegate = self
                self.dataSource = self
            }
        }
    }
    
    func setup(topGamesResponse: TopLevelResponse) {
        self.topLevelResponse = topGamesResponse
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    private func registerCells() {
        for reuseID in [Constants.featuredCellReuseID, Constants.regularGameCellReuseID] {
            self.register(UINib(nibName: reuseID, bundle: nil), forCellWithReuseIdentifier: reuseID)
        }
    }
}

extension TCMainCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topLevelResponse?.topGames.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        
        // First cell is featured cell
        if indexPath.item == 0 {
            return TCTopFeaturedCollectionViewCell.sizeFor(screenWidth: cellWidth)
        } else {
            return TCGameCollectionViewCell.sizeFor(screenWidth: cellWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // First cell is featured cell
        if indexPath.item == 0 {
            if let featuredCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.featuredCellReuseID, for: indexPath) as? TCTopFeaturedCollectionViewCell {
                return featuredCell
            }
        } else {
            if let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.regularGameCellReuseID, for: indexPath) as? TCGameCollectionViewCell {
                return gameCell
            }
        }
        
        return UICollectionViewCell()
    }
}
