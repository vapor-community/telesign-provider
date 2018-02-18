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
    let mockRequest = MockAPIRequest()

    func testSenVoiceCallReturnsAProperModel() throws
    {
        let responseBody = HTTPBody(postJsonData)
        
        let model = try mockRequest.serializedResponse(response: HTTPResponse(body: responseBody)) as Future<TelesignVoiceResponse>
        
        model.do { (voiceResponse) in
            
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
        let responseBody = HTTPBody(getJsonData)
        
        let model = try mockRequest.serializedResponse(response: HTTPResponse(body: responseBody)) as Future<TelesignVoiceResponse>

        model.do { (voiceResponse) in
            
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
                XCTAssertTrue(input["userInput"] == "6", "User input was not 6 It was: \(input)")
            default:
                XCTFail("No voice value present")
            }
            
            }.catch { (error) in
                XCTFail(error.localizedDescription)
        }
    }
    
    let postJsonData = """
        {
            "reference_id": "0123456789ABCDEF0123456789ABCDEF",
            "status": {
                    "code": 103,
                    "updated_on": "2017-02-01T00:33:34.860418Z",
                    "description": "Message in progress"
            },
            "voice": "f-en-GB"
        }
        """.data(using: .utf8)!
    
    let getJsonData = """
        {
        "reference_id": "ABCDEF0123456789ABCDEF0123456789",
        "status": {
           "code": 290,
           "updated_on": "2017-02-01T00:33:34.860418Z",
           "description": "Message in progress"
           },
        "voice": {
            "user_input": "6"
            }
        }
        """.data(using: .utf8)!
}
