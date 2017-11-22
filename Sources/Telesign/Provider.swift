//
//  Provider.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor
import Service

public struct TelesignConfig
{
    let apiKey: String
    let clientId: String
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
        
        telesign = TClient(apiKey: apiKey, clientId: clientId)
    }
    
    public func boot(_ container: Container) throws
    {
        telesign.initialize()
    }
    
    public func register(_ services: inout Services) throws {}
    
//    public convenience init(config: Config) throws
//    {
//        guard let telesignConfig = config["telesign"]?.object else {
//            throw TelesignError.missingConfig
//        }
//        guard let apiKey = telesignConfig["apiKey"]?.string else {
//            throw TelesignError.missingAPIKey
//        }
//
//        guard let clientId = telesignConfig["clientId"]?.string else {
//            throw TelesignError.missingClientId
//        }
//
//        try self.init(apiKey: apiKey, clientId: clientId)
//    }
//
//    public init(apiKey: String, clientId: String) throws
//    {
//        self.apiKey = apiKey
//        self.clientId = clientId
//        self.telesign = TelesignClient(apiKey: apiKey, clientId: clientId)
//    }
//
//    public func boot(_ drop: Droplet)
//    {
//        self.telesign.initialize()
//        drop.telesign = self.telesign
//    }
//
//    public func boot(_ config: Configs.Config) throws {
//
//    }
//
//    public func afterInit(_ drop: Droplet) {
//
//    }
//
//    public func beforeRun(_ drop: Droplet) {
//
//    }
}
