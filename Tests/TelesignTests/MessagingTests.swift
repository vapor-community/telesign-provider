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

class MessagingTests: XCTestCase {
    let mockRequest = MockAPIRequest()
    let headers: HTTPHeaders = ["Content-Type": MediaType.json.description]
    
    func testSendMessageReturnsAProperModel() throws {
        let responseBody = HTTPBody(string: postJsonData)
        
        let model = try mockRequest.serializedResponse(response: HTTPResponse(headers: headers, body: responseBody), worker: EmbeddedEventLoop()) as Future<TelesignMessageResponse>
        
        model.do { (messageResponse) in
            
            XCTAssertNotNil(messageResponse, "Message response was nil")
            
            XCTAssertNotNil(messageResponse.referenceId, "Reference Id is nil")
            
            XCTAssertNotNil(messageResponse.status, "Status is nil")
            
            XCTAssertNotNil(messageResponse.status.code, "Status code is nil")
            
            XCTAssertNotNil(messageResponse.status.updatedOn, "Status updated on is nil")
            
            XCTAssertNotNil(messageResponse.status.description, "Status description is nil")
            
            }.catch { (error) in
                XCTFail("\(error)")
        }
    }
    
    func testGetMessageStatusReturnsAProperModel() throws {
        let responseBody = HTTPBody(string: postJsonData)
        
        let model = try mockRequest.serializedResponse(response: HTTPResponse(headers: headers, body: responseBody), worker: EmbeddedEventLoop()) as Future<TelesignMessageResponse>
        
        model.do { (messageResponse) in
            
            XCTAssertNotNil(messageResponse, "Message response was nil")
            
            XCTAssertNotNil(messageResponse.referenceId, "Reference Id is nil")
                        
            XCTAssertNotNil(messageResponse.status, "Status is nil")
            
            XCTAssertNotNil(messageResponse.status.code, "Status code is nil")
            
            XCTAssertNotNil(messageResponse.status.updatedOn, "Status updated on is nil")
            
            XCTAssertNotNil(messageResponse.status.description, "Status description is nil")
            
            }.catch { (error) in
                XCTFail("\(error)")
        }
    }
    
    let postJsonData = """
        {
            "reference_id": "0123456789ABCDEF0123456789ABCDEF",
            "status": {
                    "code": 290,
                    "updated_on": "2017-02-01T00:33:34.860418Z",
                    "description": "Message in progress"
                    }
        }
        """

    let getJsonData = """
        {
        "reference_id": "ABCDEF0123456789ABCDEF0123456789",
        "status": {
           "code": 290,
           "updated_on": "2017-02-01T00:33:34.860418Z",
           "description": "Message in progress"
           }
        }
        """
}
