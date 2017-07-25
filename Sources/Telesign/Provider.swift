//
//  Provider.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor


private var _telesign: TelesignClient?

extension Droplet
{
    /*
     Enables use of the `drop.telesign?` convenience methods.
     */
    public var telesign: TelesignClient?
    {
        get {
            return _telesign
        }
        set {
            _telesign = newValue
        }
    }
}

public final class Provider: Vapor.Provider
{
    public static let repositoryName = "vapor-telesign"
    
    public let apiKey: String
    public let clientId: String
    public let telesign: TelesignClient
    
    public convenience init(config: Config) throws
    {
        guard let telesignConfig = config["telesign"]?.object else {
            throw TelesignError.missingConfig
        }
        guard let apiKey = telesignConfig["apiKey"]?.string else {
            throw TelesignError.missingAPIKey
        }
        
        guard let clientId = telesignConfig["clientId"]?.string else {
            throw TelesignError.missingClientId
        }
        
        try self.init(apiKey: apiKey, clientId: clientId)
    }
    
    public init(apiKey: String, clientId: String) throws
    {
        self.apiKey = apiKey
        self.clientId = clientId
        self.telesign = TelesignClient(apiKey: apiKey, clientId: clientId)
    }
    
    public func boot(_ drop: Droplet)
    {
        self.telesign.initialize()
        drop.telesign = self.telesign
    }
    
    public func boot(_ config: Configs.Config) throws {
        
    }
    
    public func afterInit(_ drop: Droplet) {
        
    }
    
    public func beforeRun(_ drop: Droplet) {
        
    }
}
