//
//  MockTelesignClient.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 11/19/17.
//

import Foundation
import Telesign

class MocktelesignClient: TelesignClient
{
    var apiKey: String
    
    var clientId: String
    
    var messaging: MessageRoute!
    
    var phoneid: PhoneRoute!
    
    var score: ScoreRoute!
    
    var voice: VoiceRoute!
    
    var initializedCalled = false
    
    required init(apiKey: String, clientId: String)
    {
        self.apiKey = apiKey
        self.clientId = clientId
    }
    
    func initialize()
    {
        initializedCalled = true
    }
}
