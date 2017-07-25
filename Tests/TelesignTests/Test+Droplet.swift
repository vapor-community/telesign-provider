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
                "apiKey": "rSXsJDSK2hWi1CtzX/RbPtuTnZ7dybjFVS7gcJKkhqXa4RRQ5gkbP3TGNUwiqpu0cXxG5oblzu19X51//aIRLw==",
                "clientId": "FE3897C7-55B7-4A01-A9D4-D2358EF8CF17"
            ],
            ])
        try config.addProvider(Telesign.Provider.self)
        return try Droplet(config: config)
    }
}
