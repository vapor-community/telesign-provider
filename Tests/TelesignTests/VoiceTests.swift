//
//  VoiceTests.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/29/17.
//
//

import XCTest

@testable import Telesign
@testable import Vapor

class VoiceTests: XCTestCase
{
    var drop: Droplet?
    var referenceId: String = ""
    
    override func setUp()
    {
        do
        {
            drop = try self.makeDroplet()
            
            referenceId = try drop?.telesign?.voice.send(message: "Hello Vapor",
                                                             to: "16143838792",
                                                             messageType: MessageType.ARN,
                                                             voice: .englishUS,
                                                             callbackUrl: nil,
                                                             lifecycleEvent: nil,
                                                             originatingIp: nil).referenceId ?? ""
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
    
    override func tearDown() {
        drop = nil
        referenceId = ""
    }
    
    func testGetMessageSatus() throws
    {
        do
        {
            let response = try drop?.telesign?.voice.getResultFor(reference: referenceId)
            
            XCTAssertNotNil(response)
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
    }
    
    func testCallSuccessfullyPlaced() throws
    {
        do
        {
            let response = try drop?.telesign?.voice.getResultFor(reference: referenceId)
            
            XCTAssertNotNil(response)
            
            XCTAssertNotEqual(response?.code, 104)
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
    }
}

