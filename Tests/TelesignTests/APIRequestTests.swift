//
//  APIRequestTests.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 12/2/17.
//

import XCTest

@testable import Telesign
@testable import Vapor
@testable import Crypto

class APIRequestTests: XCTestCase
{
    func testGenerateHeadersWorksProperly()
    {
        let expectedSignature = "l/CIJhABrXBgflEHLQpsXJSKbqok1gilnobirA9umbQ="
        let stringToSign = "POST\napplication/x-www-form-urlencoded\n\nx-ts-auth-method:HMAC-SHA256\nx-ts-date:Sun, 17 Dec 2017 20:53:14 GMT\naccount_lifecycle_event=create&message=Your reset code is 610190. This code will expire in 10 minutes.&phone_number=12512633579&message_type=ARN\n/v1/messaging".data(using: .utf8) ?? Data()
        
        let apiKey = "rSXsJDSK2hWi1CtzX/RbPtuTnZ7dybjFVS7gcJKkhqXa4RRQ5gkbP3TGNUwiqpu0cXxG5oblzu19X51//aIRLw=="
        
        let encoder = Base64Encoder(encoding: .base64)
        let decoder = Base64Decoder(encoding: .base64)
        
        do
        {
            let actualSignature = String(data: try encoder.encode(data: HMAC<SHA256>.authenticate(stringToSign, withKey: decoder.decode(string: apiKey))), encoding: .utf8) ?? ""
            
            XCTAssertTrue(actualSignature == expectedSignature, "Signatures didn't match")
        }
        catch
        {
            XCTFail("Unknown")
        }
    }
}
