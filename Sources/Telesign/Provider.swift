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
    let customerId: String
    
    public init(apiKey: String, customerId: String) {
        self.apiKey = apiKey
        self.customerId = customerId
    }
}

public final class TelesignProvider: Provider {
    public static let repositoryName = "telesign-provider"
    
    public init() {}
    
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

public final class TelesignClient: Service {
    public let messaging: MessageRoute
    public let phoneid: PhoneRoute
    public let score: ScoreRoute
    public let voice: VoiceRoute
    
    internal init(config: TelesignConfig, client: Client) {
        let apiRequest = APIRequest(apiKey: config.apiKey, customerId: config.customerId, httpClient: client)
        messaging = Message(request: apiRequest)
        phoneid = Phone(request: apiRequest)
        score = Score(request: apiRequest)
        voice = Voice(request: apiRequest)
    }
}
