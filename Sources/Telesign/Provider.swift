//
//  Provider.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor
import Service
import HTTP

public struct TelesignConfig
{
    let apiKey: String
    let clientId: String
    let httpClient: HTTPClient
}

public final class TelesignProvider: Provider
{
    public typealias MessageAPIRequest = APIRequest<TelesignMessageResponse>
    public typealias PhoneAPIRequest = APIRequest<TelesignPhoneIdResponse>
    public typealias ScoreAPIRequest = APIRequest<TelesignScoreResponse>
    public typealias VoiceAPIRequest = APIRequest<TelesignVoiceResponse>
    
    public static let repositoryName = "telesign-provider"
    
    private let apiKey: String
    private let clientId: String
    private let httpClient: HTTPClient
    
    public var messaging: Message<MessageAPIRequest>?
    public var phoneid: Phone<PhoneAPIRequest>?
    public var score: Score<ScoreAPIRequest>?
    public var voice: Voice<VoiceAPIRequest>?
    
    init(config: TelesignConfig)
    {
        apiKey = config.apiKey
        clientId = config.clientId
        httpClient = config.httpClient
    }
    
    public func boot(_ container: Container) throws
    {
        
        let messageAPIRequest = MessageAPIRequest(apiKey: self.apiKey, clientId: self.clientId, httpClient: self.httpClient)
        
        messaging = Message<MessageAPIRequest>(request: messageAPIRequest)
        
        
        let phoneAPIRequest = PhoneAPIRequest(apiKey: self.apiKey, clientId: self.clientId, httpClient: self.httpClient)
        
        phoneid = Phone<PhoneAPIRequest>(request: phoneAPIRequest)
        
        
        let scoreAPIRequest = ScoreAPIRequest(apiKey: self.apiKey, clientId: self.clientId, httpClient: self.httpClient)
        
        score = Score<ScoreAPIRequest>(request: scoreAPIRequest)
        
        
        let voiceAPIRequest = VoiceAPIRequest(apiKey: self.apiKey, clientId: self.clientId, httpClient: self.httpClient)
        
        voice = Voice<VoiceAPIRequest>(request: voiceAPIRequest)
    }
    
    public func register(_ services: inout Services) throws {}
}
