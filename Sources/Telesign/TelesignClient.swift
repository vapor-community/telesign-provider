//
//  TelesignClient.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Foundation
import HTTP

public protocol TelesignClient
{
    var apiKey: String { get }
    var clientId: String { get }
    var httpClient: HTTPClient { get }
    
    var messaging: MessageRoute! { get }
    var phoneid: PhoneRoute! { get }
    var score: ScoreRoute! { get }
    var voice: VoiceRoute! { get }
    
    init(apiKey: String, clientId: String, client: HTTPClient)
    
    func initializeMessageRoutes(with route: MessageRoute)
    
    func initializePhoneRoutes(with route: PhoneRoute)
    
    func initializeScoreRoutes(with route: ScoreRoute)
    
    func initializeVoiceRoutes(with route: VoiceRoute)
}

public class TClient: TelesignClient
{
    public var apiKey: String
    public var clientId: String
    public var httpClient: HTTPClient
    
    public var messaging: MessageRoute!
    public var phoneid: PhoneRoute!
    public var score: ScoreRoute!
    public var voice: VoiceRoute!
    
    public required init(apiKey: String, clientId: String, client: HTTPClient)
    {
        self.apiKey = apiKey
        self.clientId = clientId
        self.httpClient = client
    }
    
    public func initializeMessageRoutes(with route: MessageRoute)
    {
        self.messaging = route
    }
    
    public func initializePhoneRoutes(with route: PhoneRoute)
    {
        self.phoneid = route
    }
    
    public func initializeScoreRoutes(with route: ScoreRoute)
    {
        self.score = route
    }
    
    public func initializeVoiceRoutes(with route: VoiceRoute)
    {
        self.voice = route
    }
}
