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
    var voiceRoute: Voice<MockVoiceAPIRequest<TelesignVoiceResponse>>!
    
    override func setUp()
    {
        let mockRequest = MockVoiceAPIRequest<TelesignVoiceResponse>()
        
        voiceRoute = Voice(request: mockRequest)
    }
    
    func testSenVoiceCallReturnsAProperModel() throws
    {
        let response = try voiceRoute.send(message: "", to: "", messageType: .ARN)
        
        response.do { (voiceResponse) in
            
            XCTAssertNotNil(voiceResponse, "Message response was nil")
            
            XCTAssertNotNil(voiceResponse.referenceId, "Reference Id is nil")
            
            XCTAssertNotNil(voiceResponse.status, "Status is nil")
            
            XCTAssertNotNil(voiceResponse.status?.code, "Status code is nil")
            
            XCTAssertNotNil(voiceResponse.status?.updatedOn, "Status updated on is nil")
            
            XCTAssertNotNil(voiceResponse.status?.description, "Status description is nil")
            
            XCTAssertNotNil(voiceResponse.voice, "Voice is nil")
            
            switch voiceResponse.voice
            {
            case .voice(let voice)?:
                    XCTAssertTrue(voice == .englishUK, "Incorrect Voice format")
            case .userInput(let input)?:
                    XCTFail("Expected a single language got back a dictionary \(input)")
            default:
                XCTFail("No voice value present")
            }
            
            }.catch { (error) in
                XCTFail(error.localizedDescription)
        }
    }
    
    func testGetCallStatusReturnsAProperModel() throws
    {
        let response = try voiceRoute.getResultFor(reference: "")
        
        response.do { (voiceResponse) in
            
            XCTAssertNotNil(voiceResponse, "Message response was nil")
            
            XCTAssertNotNil(voiceResponse.referenceId, "Reference Id is nil")
            
            XCTAssertNotNil(voiceResponse.status, "Status is nil")
            
            XCTAssertNotNil(voiceResponse.status?.code, "Status code is nil")
            
            XCTAssertNotNil(voiceResponse.status?.updatedOn, "Status updated on is nil")
            
            XCTAssertNotNil(voiceResponse.status?.description, "Status description is nil")
            
            XCTAssertNotNil(voiceResponse.voice, "Voice is nil")

            switch voiceResponse.voice
            {
            case .voice(let voice)?:
                XCTFail("Expected a dictionary got back a single value \(voice.rawValue)")
            case .userInput(let input)?:
                XCTAssertTrue(input["user_input"] == "6", "User input was not 6")
            default:
                XCTFail("No voice value present")
            }
            
            }.catch { (error) in
                XCTFail(error.localizedDescription)
        }
    }
}
