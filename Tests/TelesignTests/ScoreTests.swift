//
//  ScoreTests.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import XCTest

@testable import Telesign
@testable import Vapor

class ScoreTests: XCTestCase
{
    func testPhoneIdIsAccurate() throws
    {
        do
        {
            let drop = try self.makeDroplet()
            
            let score = try drop.telesign?.score.get(for: "", lifecycleEvent: .transact, originatingIp: nil, deviceId: nil, accountId: nil, emailAddress: nil)
            
            XCTAssertNotNil(score)
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
