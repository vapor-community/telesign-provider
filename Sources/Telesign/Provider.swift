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
    public static let repositoryName = "telesign-provider"
    
    public let apiKey: String
    public let clientId: String
    public var telesign: TelesignClient
    
    init(config: TelesignConfig)
    {
        apiKey = config.apiKey
        clientId = config.clientId
        
        telesign = TClient(apiKey: apiKey, clientId: clientId, client: config.httpClient)
    }
    
    public func boot(_ container: Container) throws
    {
        telesign.initializeMessageRoutes(with: Message(request: APIRequest<TelesignMessageResponse>(telesign)))
        telesign.initializePhoneRoutes(with: Phone(request: APIRequest<TelesignPhoneIdResponse>(telesign)))
        telesign.initializeScoreRoutes(with: Score(request: APIRequest<TelesignScoreResponse>(telesign)))
        // TODO: - Implement Voice Routes after telesign updates their API to handle dates correctly.
    }
    
    public func register(_ services: inout Services) throws {}
}
