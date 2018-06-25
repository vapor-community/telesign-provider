//
//  MockAPIRequest.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 11/19/17.
//

@testable import Telesign

struct MockAPIRequest: TelesignRequest {
    var apiKey: String = ""
    var customerId: String = ""
}
