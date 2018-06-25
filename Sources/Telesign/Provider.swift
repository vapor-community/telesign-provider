//
//  Provider.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor

public struct TelesignConfig: Service {
    let apiKey: String
    let clientId: String
    
    public init(apiKey: String, clientId: String) {
        self.apiKey = apiKey
        self.clientId = clientId
    }
}

public final class TelesignProvider: Provider {
    public static let repositoryName = "telesign-provider"
    
    public func boot(_ container: Container) throws {}
    
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
    
    public func register(_ services: inout Services) throws {
        services.register { (container) -> TelesignClient in
            let httpClient = try container.make(Client.self)
            let config = try container.make(TelesignConfig.self)
            return TelesignClient(config: config, client: httpClient)
        }
    }
}

public struct TelesignClient: Service {
    public let messaging: Message
    public let phoneid: Phone
    public let score: Score
    public let voice: Voice
    
    internal init(config: TelesignConfig, client: Client) {
        let apiRequest = APIRequest(apiKey: config.apiKey, clientId: config.clientId, httpClient: client)
        messaging = Message(request: apiRequest)
        phoneid = Phone(request: apiRequest)
        score = Score(request: apiRequest)
        voice = Voice(request: apiRequest)
    }
}
