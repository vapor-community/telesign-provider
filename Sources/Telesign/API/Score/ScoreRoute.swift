//
//  Score.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

public protocol ScoreRoute
{
    var client: TelesignClient { get }
    
    func get(for number: String, lifecycleEvent: AccountLifecycleEvent, originatingIp: String?, deviceId: String?, accountId: String?, emailAddress: String?) throws -> ScoreResponse
}

public struct Score: ScoreRoute
{
    public let client: TelesignClient
    
    init(client: TelesignClient)
    {
        self.client = client
    }
    
    public func get(
        for number: String,
        lifecycleEvent: AccountLifecycleEvent,
        originatingIp: String? = nil,
        deviceId: String? = nil,
        accountId: String? = nil,
        emailAddress: String? = nil
        ) throws -> ScoreResponse
    {
        var bodyData = ["account_lifecycle_event": lifecycleEvent.rawValue]
        
        if let ip = originatingIp
        {
            bodyData["originating_ip"] = ip
        }

        if let device = deviceId
        {
            bodyData["device_id"] = device
        }

        if let account = accountId
        {
            bodyData["account_id"] = account
        }

        if let email = emailAddress
        {
            bodyData["email_address"] = email
        }
        
        let request = try APIRequest<TelesignScoreResponse>(client)
        
        try request.post(path: "/v1/score/\(number)", body: bodyData)
        
        return try request.serializedResponse()
    }
}
