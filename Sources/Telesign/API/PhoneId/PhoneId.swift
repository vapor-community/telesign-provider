//
//  PhoneId.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/24/17.
//
//

import Foundation
import Vapor

public final class PhoneId
{
    let client: TelesignClient
    
    init(client: TelesignClient)
    {
        self.client = client
    }

    public func get(for number: String, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> PhoneIdResponse
    {
        var body = Node([:])
        
        if let ale = lifecycleEvent
        {
            body["account_lifecycle_event"] = Node(ale.rawValue)
        }
        
        if let ip = originatingIp
        {
            body["originating_ip"] = Node(ip)
        }
        
        let request = TelesignRequest<PhoneIdResponse>(client: self.client)
        
        _  = (body.object?.count ?? 0 > 0) ? try request.post(path: "/v1/phoneid/\(number)", body: body) : try request.post(path: "/v1/phoneid/\(number)", body: nil)
        
        return try request.serializedResponse()
    }
}
