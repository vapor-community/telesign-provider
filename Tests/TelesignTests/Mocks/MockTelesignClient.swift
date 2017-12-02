//
//  MockTelesignClient.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 11/19/17.
//

import Foundation
import Telesign
import HTTP

class MockTelesignClient: TelesignClient
{
    var apiKey: String
    var clientId: String
    var httpClient: HTTPClient
    
    var messaging: MessageRoute!
    var phoneid: PhoneRoute!
    var score: ScoreRoute!
    var voice: VoiceRoute!
    
    var initializeMessageRoutesCalled = false
    var initializePhoneRoutesCalled = false
    var initializeScoreRoutesCalled = false
    var initializeVoiceRoutesCalled = false
    
    required init(apiKey: String, clientId: String, client: HTTPClient)
    {
        self.apiKey = apiKey
        self.clientId = clientId
        self.httpClient = client
    }
    
    func initializeMessageRoutes(with route: MessageRoute)
    {
        messaging = route
        initializeMessageRoutesCalled = true
    }
    
    func initializePhoneRoutes(with route: PhoneRoute)
    {
        phoneid = route
        initializePhoneRoutesCalled = true
    }
    
    func initializeScoreRoutes(with route: ScoreRoute)
    {
        score = route
        initializeScoreRoutesCalled = true
    }
    
    func initializeVoiceRoutes(with route: VoiceRoute)
    {
        voice = route
        initializeVoiceRoutesCalled = true
    }
}
