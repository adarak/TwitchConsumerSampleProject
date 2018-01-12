//
//  TCMainViewService.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import UIKit
import PromiseKit

struct TCMainViewService {
    
    enum Constants {
        static let twitchTopGamesUrl = "https://api.twitch.tv/kraken/games/top"
        static let topGamesLimit = 30
        static let topGamesWithLimitURL = String(format: "%@?limit=%d", twitchTopGamesUrl, topGamesLimit)
    }
    
    let twitchAPISession: TwitchAPISession
    
    func getTopGames() -> Promise<TopGames> {
        return Promise { fulfill, reject in
            twitchAPISession.getData(url: Constants.topGamesWithLimitURL).then(execute: { data -> Void in
                if let decodedTopGames = self.topGamesDecoded(data: data) {
                    fulfill(decodedTopGames)
                }
            }).catch(execute: { (error) in
                reject(error)
            })
        }
    }
    
    private func topGamesDecoded(data: Data) -> TopGames? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(TopGames.self, from: data)
        } catch _ {
            return nil
        }
    }
    
    func getImage(urlString: String) -> Promise<UIImage> {
        return twitchAPISession.getImage(urlString: urlString)
    }
}
