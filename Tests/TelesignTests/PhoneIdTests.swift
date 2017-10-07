//
//  PhoneIdTests.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/24/17.
//
//

import XCTest

@testable import Telesign
@testable import Vapor

class PhoneIdTests: XCTestCase
{
    func testPhoneIdIsAccurate() throws
    {
        do
        {
            let drop = try self.makeDroplet()
            
            let phoneId = try drop.telesign?.phoneid.get(for: "16143838792", lifecycleEvent: nil, originatingIp: nil)
            
            XCTAssertNotNil(phoneId)
        }
        catch let error as TelesignError
        {
            switch error
            {
            case .malformedEncodedBody:
                XCTFail(error.localizedDescription)
            case .missingAPIKey:
                XCTFail(error.localizedDescription)
            case .missingClientId:
                XCTFail(error.localizedDescription)
            case .missingConfig:
                XCTFail(error.localizedDescription)
            case .connectionError(_):
                XCTFail(error.localizedDescription)
            }
        }
        catch
        {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
}
