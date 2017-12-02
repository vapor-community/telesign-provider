//
//  PhoneId.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/24/17.
//
//

public protocol PhoneRoute
{
    var request: APIRequest<TelesignPhoneIdResponse> { get }
    
    func getId(for number: String, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> PhoneIdResponse
}

public struct Phone: PhoneRoute
{
    public var request: APIRequest<TelesignPhoneIdResponse>
    
    init(request: APIRequest<TelesignPhoneIdResponse>)
    {
        self.request = request
    }

    public func getId(for number: String, lifecycleEvent: AccountLifecycleEvent? = nil, originatingIp: String? = nil) throws -> PhoneIdResponse
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
        
        try request.post(path: "/v1/phoneid/\(number)", body: bodyData)
        
        return try request.serializedResponse()
    }
}
