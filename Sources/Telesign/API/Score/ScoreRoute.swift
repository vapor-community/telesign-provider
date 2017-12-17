//
//  Score.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Async

public protocol ScoreRoute
{
    associatedtype SR: TelesignResponse
    
    func get(for number: String, lifecycleEvent: AccountLifecycleEvent, originatingIp: String?, deviceId: String?, accountId: String?, emailAddress: String?) throws -> Future<SR>
}

public struct Score<T>: ScoreRoute where T: TelesignRequest
{
    public typealias SR = T.TR
    private var request: T
    
    init(request: T)
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
        ) throws -> Future<SR>
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
        
        return try request.post(path: "/v1/score/\(number)", body: bodyData)
    }
}
