//
//  PhoneId.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/24/17.
//
//

import Async

public protocol PhoneRoute
{
    associatedtype PIR: TelesignResponse
    
    func getId(for number: String, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> Future<PIR>
}

public struct Phone<T>: PhoneRoute where T: TelesignRequest
{
    public typealias PIR = T.TR
    private var request: T
    
    init(request: T)
    {
        self.request = request
    }

    public func getId(for number: String, lifecycleEvent: AccountLifecycleEvent? = nil, originatingIp: String? = nil) throws -> Future<PIR>
    {
        var bodyData: [String: String] = [:]
        
        if let ale = lifecycleEvent
        {
            bodyData["account_lifecycle_event"] = ale.rawValue
        }

        if let ip = originatingIp
        {
            bodyData["originating_ip"] = ip
        }
        
        return try request.post(path: "/v1/phoneid/\(number)", body: bodyData)
    }
}
