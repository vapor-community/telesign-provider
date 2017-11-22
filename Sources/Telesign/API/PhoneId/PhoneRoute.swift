//
//  PhoneId.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/24/17.
//
//

public protocol PhoneRoute
{
    var client: TelesignClient { get }
    
    func getId(for number: String, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> PhoneIdResponse
}

public struct Phone: PhoneRoute
{
    public let client: TelesignClient
    
    init(client: TelesignClient)
    {
        self.client = client
    }

    public func getId(for number: String, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> PhoneIdResponse
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
        
        let request = try APIRequest<TelesignPhoneIdResponse>(client)
        
        try request.post(path: "/v1/phoneid/\(number)", body: bodyData)
        
        return try request.serializedResponse()
    }
}
