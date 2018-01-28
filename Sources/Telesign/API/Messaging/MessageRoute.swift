//
//  Messaging.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Async

public protocol MessageRoute
{
    associatedtype MR: MessageResponse
    
    @discardableResult
    func send(message: String, to recepient: String, messageType: MessageType, callbackURL: String?, lifecycleEvent: AccountLifecycleEvent?, senderId: String?, originatingIp: String?) throws -> Future<MR>
    
    func getResultFor(reference: String) throws -> Future<MR>
}

public struct Message: MessageRoute
{
    private let request: TelesignRequest
    
    init(request: TelesignRequest)
    {
        self.request = request
    }
    
    @discardableResult
    public func send(
        message: String,
        to recepient: String,
        messageType: MessageType,
        callbackURL: String? = nil,
        lifecycleEvent: AccountLifecycleEvent? = nil,
        senderId: String? = nil,
        originatingIp: String? = nil
        ) throws -> Future<TelesignMessageResponse>
    {
        
        var bodyData = [
            "message": message,
            "phone_number": recepient,
            "message_type": messageType.rawValue
        ]
        
        if let callbackurl = callbackURL
        {
            bodyData["callback_url"] = callbackurl
        }
        
        if let ale = lifecycleEvent
        {
            bodyData["account_lifecycle_event"] = ale.rawValue
        }
        
        if let senderId = senderId
        {
            bodyData["sender_id"] = senderId
        }
        
        if let ip = originatingIp
        {
            bodyData["originating_ip"] = ip
        }
        
        return try request.post(path: "/v1/messaging", body: bodyData)
    }
    
    public func getResultFor(reference: String) throws -> Future<TelesignMessageResponse>
    {
       return try request.get(path: "/v1/messaging/\(reference)")
    }
}
