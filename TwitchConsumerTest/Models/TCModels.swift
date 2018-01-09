//
//  TCModels.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit

struct TopGames: Decodable {
    var games: [Game]
    var totalGames: Int
    
    enum CodingKeys: String, CodingKey {
        case games = "top"
        case totalGames = "_total"
    }
}

struct Game: Decodable {
    var gameDetails: GameDetails
    var viewers: Int
    var channels: Int
    
    enum CodingKeys: String, CodingKey {
        case gameDetails = "game"
        case viewers
        case channels
    }
}

struct GameDetails: Decodable {
    var name: String
    var popularity: Int
    var box: GameBoxArt
    
    enum CodingKeys: String, CodingKey {
        case name
        case popularity
        case box
    }
}

struct GameBoxArt: Decodable {
    
    var small: String
    var medium: String
    var large: String
    
    enum CodingKeys: String, CodingKey {
        case large
        case medium
        case small
    }
}
