//
//  Provider.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor

public struct TelesignConfig
{
    let apiKey: String
    let clientId: String
}

public final class TelesignProvider: Provider
{
    public static let repositoryName = "telesign-provider"
    
    public func boot(_ container: Container) throws {}
    
    public func register(_ services: inout Services) throws
    {
        services.register { (container) -> TelesignClient in
            let httpClient = try container.make(Client.self, for: TelesignClient.self)
            let config = try container.make(TelesignConfig.self, for: TelesignClient.self)
            return TelesignClient(config: config, client: httpClient)
        }
    }
}

public struct TelesignClient: Service
{
    public typealias MessageAPIRequest = APIRequest<TelesignMessageResponse>
    public typealias PhoneAPIRequest = APIRequest<TelesignPhoneIdResponse>
    public typealias ScoreAPIRequest = APIRequest<TelesignScoreResponse>
    public typealias VoiceAPIRequest = APIRequest<TelesignVoiceResponse>
    
    public let messaging: Message<MessageAPIRequest>
    public let phoneid: Phone<PhoneAPIRequest>
    public let score: Score<ScoreAPIRequest>
    public let voice: Voice<VoiceAPIRequest>
    
    init(config: TelesignConfig, client: Client)
    {
        let messageAPIRequest = MessageAPIRequest(apiKey: config.apiKey, clientId: config.clientId, httpClient: client)
        
        messaging = Message<MessageAPIRequest>(request: messageAPIRequest)
        
        let phoneAPIRequest = PhoneAPIRequest(apiKey: config.apiKey, clientId: config.clientId, httpClient: client)
        
        phoneid = Phone<PhoneAPIRequest>(request: phoneAPIRequest)
        
        let scoreAPIRequest = ScoreAPIRequest(apiKey: config.apiKey, clientId: config.clientId, httpClient: client)
        
        score = Score<ScoreAPIRequest>(request: scoreAPIRequest)
        
        let voiceAPIRequest = VoiceAPIRequest(apiKey: config.apiKey, clientId: config.clientId, httpClient: client)
        
        voice = Voice<VoiceAPIRequest>(request: voiceAPIRequest)
    }
}
