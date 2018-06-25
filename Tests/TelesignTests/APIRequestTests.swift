//
//  APIRequestTests.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 12/2/17.
//

import XCTest
@testable import Vapor
@testable import Crypto

class APIRequestTests: XCTestCase {
    func testGenerateHeadersWorksProperly() throws {
        
        var api = MockAPIRequest()
        api.apiKey = "rSXsJDSK2hWi1CtzX/RbPtuTnZ7dybjFVS7gcJKkhqXa4RRQ5gkbP3TGNUwiqpu0cXxG5oblzu19X51//aIRLw=="
        api.customerId = "Hello"
        
        let headers = try api.generateHeaders(path: "/v1/messaging", method: .POST, body: ["message": "Your reset code is 610190. This code will expire in 10 minutes.",
                                                                                           "phone_number": "1234567890",
                                                                                           "message_type": "ARN"])
        XCTAssert(headers.contains(name: HTTPHeaderName.authorization))
        XCTAssert(headers.contains(name: HTTPHeaders.Key("x-ts-date")))
        XCTAssert(headers.contains(name: HTTPHeaders.Key("x-ts-auth-method")))
        XCTAssertEqual(headers[HTTPHeaderName.contentType.description][0], "application/x-www-form-urlencoded")
    }
}
