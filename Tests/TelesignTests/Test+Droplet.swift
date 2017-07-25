//
//  Test+Droplet.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/22/17.
//
//

import Foundation
import XCTest
import Vapor
import Telesign

extension XCTestCase {
    func makeDroplet() throws -> Droplet {
        let config = Config([
            "telesign": [
                "apiKey": "",// Add your own api Key
                "clientId": "" // Add your own clientId
            ],
            ])
        try config.addProvider(Telesign.Provider.self)
        return try Droplet(config: config)
    }
}
