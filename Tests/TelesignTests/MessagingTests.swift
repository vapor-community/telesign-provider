//
//  MessagingTests.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/22/17.
//
//


import XCTest

@testable import Telesign
@testable import Vapor

class MessagingTests: XCTestCase
{
    var drop: Droplet?
    var referenceId: String = ""
    
    override func setUp()
    {
        do
        {
            drop = try self.makeDroplet()
            
            referenceId = try drop?.telesign?.messaging.send(message: "Telesign Vapor",
                                                             to: "12512633579",
                                                             messageType: MessageType.ARN,
                                                             callbackUrl: nil,
                                                             lifecycleEvent: nil,
                                                             senderId: nil,
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
            let response = try drop?.telesign?.messaging.getResultFor(reference: referenceId)
            
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
    
    func testMessageSuccessfullyDeliveredAFter10Seconds() throws
    {
        do
        {
            sleep(10)
            
            let response = try drop?.telesign?.messaging.getResultFor(reference: referenceId)
            
            XCTAssertNotNil(response)
            
            XCTAssertEqual(response?.code, 200)
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
