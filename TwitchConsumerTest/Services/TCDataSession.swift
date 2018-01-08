//
//  TwitchAPI.swift
//  TwitchConsumerTest
//
//  Created by Envoy on 1/7/18.
//  Copyright © 2018 Adam Ake. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

protocol TwitchAPISession {
    
    // Promises?
    typealias DataResponseHandler = (Data?) -> ()
    func getData(url: String, dataResponseHandler: @escaping DataResponseHandler)
}

class TCDataSession: TwitchAPISession {
    
    static let shared = TCDataSession()
    
    // Blocks instantiation, so that only the shared instance may be messaged.
    private init() {}
    
    private enum Constants {
        static let twitchHeaderIDKey = "Client-ID"
        static let apiKeyKey = "apikey"
        static let plist = "plist"
    }
    
    func apiKey() -> String? {
        if let path = Bundle.main.path(forResource: Constants.apiKeyKey, ofType: Constants.plist) {
            if let data: Data =  FileManager.default.contents(atPath: path) {
                do {
                    if let plistDict = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] {
                        if let key = plistDict[Constants.apiKeyKey] as? String {
                            return key
                        }
                    }
                } catch {
                    print("Couldn't read from plist")
                }
            }
        }
        return nil
    }
    
    func getData(url: String, dataResponseHandler: @escaping DataResponseHandler) {
        if let apiKey = self.apiKey() {
            let headers: HTTPHeaders = [Constants.twitchHeaderIDKey: apiKey]
            Alamofire.request(url, headers: headers).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(_):
                    if let data = response.data {
                        dataResponseHandler(data)
                    }
                case .failure(_):
                    dataResponseHandler(nil)
                }
            })
        } else {
            dataResponseHandler(nil)
            print("🔑 MISSING API KEY")
        }
    }
}
