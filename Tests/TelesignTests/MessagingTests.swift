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
@testable import HTTP

class MessagingTests: XCTestCase
{
    var messageRoute: Message!

    override func setUp()
    {
        do
        {
            let httpclient = try HTTPClient.connect(to: "https://www.google.com", ssl: false, on: DispatchQueue(label: "test")).blockingAwait()
            
            let mockClient = MockTelesignClient(apiKey: "", clientId: "", client: httpclient)
            
            let mockRequest = MockMessageAPIRequest<TelesignMessageResponse>(mockClient)
            
            messageRoute = Message(request: mockRequest)

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
    
    func testSendMessageReturnsAProperModel() throws
    {
        let response = try messageRoute.send(message: "", to: "", messageType: .ARN)
        
        XCTAssertTrue((messageRoute.request as? MockMessageAPIRequest)?.postCalled ?? false)
        
        XCTAssertNotNil(response, "Message response was nil")
        
        XCTAssertNotNil(response.referenceId, "Reference Id is nil")
        
        XCTAssertNotNil(response.status, "Status is nil")
        
        XCTAssertNotNil(response.status?.code, "Status code is nil")
        
        XCTAssertNotNil(response.status?.updatedOn, "Status updated on is nil")
        
        XCTAssertNotNil(response.status?.description, "Status description is nil")
        
        XCTAssertNil(response.submitTimestamp, "Timestamp is not nil")
    }
    
    func testGetMessageStatusReturnsAProperModel() throws
    {
        let response = try messageRoute.getResultFor(reference: "")
        
        XCTAssertTrue((messageRoute.request as? MockMessageAPIRequest)?.getCalled ?? false)
        
        XCTAssertNotNil(response, "Message response was nil")
        
        XCTAssertNotNil(response.referenceId, "Reference Id is nil")
        
        XCTAssertNotNil(response.submitTimestamp, "Timestamp is nil")
        
        XCTAssertNotNil(response.status, "Status is nil")
        
        XCTAssertNotNil(response.status?.code, "Status code is nil")
        
        XCTAssertNotNil(response.status?.updatedOn, "Status updated on is nil")
        
        XCTAssertNotNil(response.status?.description, "Status description is nil")
    }
}
