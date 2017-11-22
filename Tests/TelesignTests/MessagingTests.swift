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
    // Setup client
    // setup a spy request
    // initialize a route
    // call send and get functions and expect the models to be serialized properly via codable.
    
    var postJsonData = """
        {
            "reference_id": "0123456789ABCDEF0123456789ABCDEF",
            "status": {
                    "code": 290,
                    "updated_on": "2015-10-03T14:51:28.709526Z",
                    "description": "Message in progress"
                    }
        }
 """.data(using: .utf8)!
    
    var getJsonData = """
                {
        "reference_id": "ABCDEF0123456789ABCDEF0123456789",
        "submit_timestamp": "Tue, 31 Jan 2017 13:36:07 GMT",
        "status": {
           "code": 290,
           "updated_on": "Tue, 31 Jan 2017 13:36:11 GMT",
           "description": "Message in progress"
           }
        }
""".data(using: .utf8)!
    
    var message: TelesignMessageResponse!
    
    override func setUp()
    {
        let client = MocktelesignClient(apiKey: "", clientId: "")
        
        let request = APIRequest<TelesignMessageResponse>(client)
        
        let body = Body(postJsonData)
        
        request.response = Response(version: Version.init(major: 1, minor: 1) , status: HTTP.Status.ok, headers: Headers(), body: body)
        
        client.messaging = Message(request: request)
        
        do
        {
            message = try client.messaging.request.serializedResponse()
            
            //print(message)
//            drop = try self.makeDroplet()
//
//            referenceId = try drop?.telesign?.messaging.send(message: "Telesign Vapor",
//                                                             to: "16143838792",
//                                                             messageType: MessageType.ARN,
//                                                             callbackUrl: nil,
//                                                             lifecycleEvent: nil,
//                                                             senderId: nil,
//                                                             originatingIp: nil).referenceId ?? ""
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
    
    func testMessageNotNil()
    {
        print(message)
        XCTAssertNotNil(message)
    }
}
