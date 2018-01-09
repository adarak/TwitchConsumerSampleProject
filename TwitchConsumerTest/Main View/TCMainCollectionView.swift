//
//  TCMainCollectionView.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

class TCMainCollectionView: UICollectionView {
    
    var topGames: TopGames?
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
                
                self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
                
                self.delegate = self
                self.dataSource = self
            }
        }
    }
    
    func setup(topGames: TopGames) {
        self.topGames = topGames
        
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
        return topGames?.games.count ?? 0
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
                featuredCell.setup(model: gameInfo(indexPath: indexPath))
                return featuredCell
            }
        } else {
            if let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.regularGameCellReuseID, for: indexPath) as? TCGameCollectionViewCell {
                gameCell.setup(model: gameInfo(indexPath: indexPath))
                return gameCell
            }
        }
        
        return UICollectionViewCell()
    }
    
    private func gameInfo(indexPath: IndexPath) -> Game? {
        if let topGames = self.topGames {
            if indexPath.item < topGames.games.count {
                return topGames.games[indexPath.item]
            }
        }
        return nil
    }
}
