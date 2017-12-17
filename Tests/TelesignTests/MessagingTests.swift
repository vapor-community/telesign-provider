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
    var messageRoute: Message<MockMessageAPIRequest<TelesignMessageResponse>>!

    override func setUp()
    {
        let mockRequest = MockMessageAPIRequest<TelesignMessageResponse>()
            
        messageRoute = Message(request: mockRequest)
    }
    
    func testSendMessageReturnsAProperModel() throws
    {
        let response = try messageRoute.send(message: "", to: "", messageType: .ARN)
        
        response.do { (messageResponse) in
            
            XCTAssertNotNil(messageResponse, "Message response was nil")
            
            XCTAssertNotNil(messageResponse.referenceId, "Reference Id is nil")
            
            XCTAssertNotNil(messageResponse.status, "Status is nil")
            
            XCTAssertNotNil(messageResponse.status?.code, "Status code is nil")
            
            XCTAssertNotNil(messageResponse.status?.updatedOn, "Status updated on is nil")
            
            XCTAssertNotNil(messageResponse.status?.description, "Status description is nil")
            
            }.catch { (error) in
                XCTFail(error.localizedDescription)
            }
    }
    
    func testGetMessageStatusReturnsAProperModel() throws
    {
        let response = try messageRoute.getResultFor(reference: "")
        
        response.do { (messageResponse) in
            
            XCTAssertNotNil(messageResponse, "Message response was nil")
            
            XCTAssertNotNil(messageResponse.referenceId, "Reference Id is nil")
                        
            XCTAssertNotNil(messageResponse.status, "Status is nil")
            
            XCTAssertNotNil(messageResponse.status?.code, "Status code is nil")
            
            XCTAssertNotNil(messageResponse.status?.updatedOn, "Status updated on is nil")
            
            XCTAssertNotNil(messageResponse.status?.description, "Status description is nil")
            
            }.catch { (error) in
                XCTFail(error.localizedDescription)
        }
    }
}
