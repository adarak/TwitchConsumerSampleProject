//
//  TwitchConsumerTestTests.swift
//  TwitchConsumerTestTests
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import XCTest
import PromiseKit
import Alamofire
import AlamofireImage
@testable import TwitchConsumerTest

class TwitchConsumerTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDecodeTopGames() {
        let testSession = TestTCDataSession()
        let testMainViewService = TCMainViewService.init(twitchAPISession: testSession)
        let topGamesDecoded = testMainViewService.getTopGames()
        XCTAssertNotNil(topGamesDecoded)
    }
}

struct TestTCDataSession: TwitchAPISession {
    
    func getData(url: String) -> Promise<Data> {
        let topGamesTestJSON =
        """
            {
                "_total": 1728,
                "_links": {
                    "self": "https://api.twitch.tv/kraken/games/top?limit=10",
                    "next": "https://api.twitch.tv/kraken/games/top?limit=10&offset=10"
                },
                "top": [
                    {
                        "game": {
                            "name": "League of Legends",
                            "popularity": 131843,
                            "_id": 21779,
                            "giantbomb_id": 24024,
                            "box": {
                                "large": "https://static-cdn.jtvnw.net/ttv-boxart/League%20of%20Legends-272x380.jpg",
                                "medium": "https://static-cdn.jtvnw.net/ttv-boxart/League%20of%20Legends-136x190.jpg",
                                "small": "https://static-cdn.jtvnw.net/ttv-boxart/League%20of%20Legends-52x72.jpg",
                                "template": "https://static-cdn.jtvnw.net/ttv-boxart/League%20of%20Legends-{width}x{height}.jpg"
                            },
                            "logo": {
                                "large": "https://static-cdn.jtvnw.net/ttv-logoart/League%20of%20Legends-240x144.jpg",
                                "medium": "https://static-cdn.jtvnw.net/ttv-logoart/League%20of%20Legends-120x72.jpg",
                                "small": "https://static-cdn.jtvnw.net/ttv-logoart/League%20of%20Legends-60x36.jpg",
                                "template": "https://static-cdn.jtvnw.net/ttv-logoart/League%20of%20Legends-{width}x{height}.jpg"
                            },
                            "_links": {},
                            "localized_name": "League of Legends",
                            "locale": "en-us"
                        },
                        "viewers": 132331,
                        "channels": 2266
                    },
                ]
            }
"""
        if let jsonData = topGamesTestJSON.data(using: .utf8) {
            return Promise(value: jsonData)
        } else {
            return Promise(value: Data())
        }
    }
    
    func getImage(urlString: String) -> Promise<Image> {
        return Promise(value: Image())
    }
}
