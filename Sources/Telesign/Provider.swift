//
//  Provider.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor

public struct TelesignConfig: Service
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
    public let messaging: Message
    public let phoneid: Phone
    public let score: Score
    public let voice: Voice
    
    init(config: TelesignConfig, client: Client)
    {
        let apiRequest = APIRequest(apiKey: config.apiKey, clientId: config.clientId, httpClient: client)
        
        messaging = Message(request: apiRequest)
        
        phoneid = Phone(request: apiRequest)
        
        score = Score(request: apiRequest)
        
        voice = Voice(request: apiRequest)
    }
}
