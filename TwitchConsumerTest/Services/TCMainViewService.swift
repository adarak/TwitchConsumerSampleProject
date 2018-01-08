//
//  TCMainViewService.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import Foundation
import PromiseKit

struct TCMainViewService {
    
    enum Constants {
        static let twitchTopGamesUrl = "https://api.twitch.tv/kraken/games/top"
        static let topGamesLimit = 20
        static let topGamesWithLimitURL = String(format: "%@?limit=%d", twitchTopGamesUrl, topGamesLimit)
    }
    
    let twitchAPISession: TwitchAPISession
    
    func getTopGames() -> Promise<TopLevelResponse> {
        return Promise { fulfill, reject in
            twitchAPISession.getData(url: Constants.topGamesWithLimitURL, dataResponseHandler: { (data) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        fulfill(try decoder.decode(TopLevelResponse.self, from: data))
                    } catch let decodingError {
                        reject(decodingError)
                    }
                }
            })
        }
    }
}
