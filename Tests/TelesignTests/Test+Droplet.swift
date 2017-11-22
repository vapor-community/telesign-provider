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

//extension XCTestCase {
//    func makeApp() throws -> Application {
//        
//        
//        
//        let config = Config([
//            "telesign": [
//                "apiKey": "SEceQjIZwETRUCRisZOl6/SadOig2hZkL8PGDJ1Rpwr3JrBOgKnSKtGB5YvlMayMy9RzncnDNmvfN5bsW18Rqg==",// Add your own api Key
//                "clientId": "6A03D720-4818-473D-8633-FB8ABAEF35B7" // Add your own clientId
//            ],
//            ])
//        try config.addProvider(Telesign.Provider.self)
//        guard let telesignConfig = config["telesign"]?.object else {
//            throw TelesignError.missingConfig
//        }
//        guard telesignConfig["apiKey"]?.string?.characters.count ?? 0 > 1 else {
//            throw TelesignError.missingAPIKey
//        }
//        guard telesignConfig["clientId"]?.string?.characters.count ?? 0 > 1 else {
//            throw TelesignError.missingClientId
//        }
//        return try Droplet(config: config)
//    }
//}

