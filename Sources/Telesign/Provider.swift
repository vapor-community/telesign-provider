//
//  Provider.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor
@_exported import TelesignKit

public final class TelesignProvider: Provider {
    private let apiKey: String
    private let customerId: String
    public init(apiKey: String, customerId: String) {
        self.apiKey = apiKey
        self.customerId = customerId
    }
        
    public func register(_ app: Application) {
        app.register(TelesignClient.self) { app in
            return TelesignClient(eventLoop: app.make(),
                                  apiKey: self.apiKey,
                                  customerId: self.customerId)
        }
    }
}
