//
//  TelesignClientTests.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 12/2/17.
//

import XCTest

@testable import Telesign
@testable import Vapor
@testable import HTTP

class TelesignClientTests: XCTestCase
{
    func testRoutesAreProperlyInitialized() throws
    {
        let httpclient = try HTTPClient.connect(to: "https://www.google.com", ssl: false, on: DispatchQueue(label: "test")).blockingAwait()
        
        let telesignClient: DefaultTelesignClient = DefaultTelesignClient(apiKey: "", clientId: "", client: httpclient)
        
        // Message
        let mockMessageRequest = MockMessageAPIRequest<TelesignMessageResponse>(telesignClient)
        
        let mockMessageRoute = MockMessageRoute(request: mockMessageRequest)
        
        telesignClient.initializeMessageRoutes(with: mockMessageRoute)
        
        XCTAssertNotNil(telesignClient.messaging, "Message route is nil")
        
        // Phone Id
        let mockPhoneRequest = MockPhoneIDAPIRequest<TelesignPhoneIdResponse>(telesignClient)
        
        let mockPhoneRoute = MockPhoneRoute(request: mockPhoneRequest)
        
        telesignClient.initializePhoneRoutes(with: mockPhoneRoute)
        
        XCTAssertNotNil(telesignClient.phoneid, "Phone route is nil")
        
        // Score
        let mockScoreRequest = MockScoreAPIRequest<TelesignScoreResponse>(telesignClient)
        
        let mockScoreRoute = MockScoreRoute(request: mockScoreRequest)
        
        telesignClient.initializeScoreRoutes(with: mockScoreRoute)
        
        XCTAssertNotNil(telesignClient.score, "Message route is nil")
        
        // TODO: - Add tests for voice routes.
    }
}
