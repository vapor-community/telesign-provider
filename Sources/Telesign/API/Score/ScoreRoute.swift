//
//  Score.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

public protocol ScoreRoute
{
    var request: APIRequest<TelesignScoreResponse> { get }
    
    func get(for number: String, lifecycleEvent: AccountLifecycleEvent, originatingIp: String?, deviceId: String?, accountId: String?, emailAddress: String?) throws -> ScoreResponse
}

public struct Score: ScoreRoute
{
    public var request: APIRequest<TelesignScoreResponse>
    
    init(request: APIRequest<TelesignScoreResponse>)
    {
        self.request = request
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
        
        try request.post(path: "/v1/score/\(number)", body: bodyData)
        
        return try request.serializedResponse()
    }
}
