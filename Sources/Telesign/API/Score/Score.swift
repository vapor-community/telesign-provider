//
//  Score.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class Score
{
    let client: TelesignClient
    
    init(client: TelesignClient)
    {
        self.client = client
    }
    
    public func get(for number: String, lifecycleEvent: AccountLifecycleEvent, originatingIp: String?, deviceId: String?, accountId: String?, emailAddress: String?) throws -> ScoreResponse
    {
        var body = Node([:])
        
        body["account_lifecycle_event"] = Node(lifecycleEvent.rawValue)
        
        if let ip = originatingIp
        {
            body["originating_ip"] = Node(ip)
        }
        
        if let device = deviceId
        {
            body["device_id"] = Node(device)
        }
        
        if let account = accountId
        {
            body["account_id"] = Node(account)
        }
        
        if let email = emailAddress
        {
            body["email_address"] = Node(email)
        }
        
        let request = TelesignRequest<ScoreResponse>(client: self.client)
        
        _  = (body.object?.count ?? 0 > 0) ? try request.post(path: "/v1/score/\(number)", body: body) : try request.post(path: "/v1/score/\(number)", body: nil)
        
        return try request.serializedResponse()
    }

}
