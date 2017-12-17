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
    associatedtype MR: TelesignResponse
    
    @discardableResult
    func send(message: String, to recepient: String, messageType: MessageType, callbackURL: String?, lifecycleEvent: AccountLifecycleEvent?, senderId: String?, originatingIp: String?) throws -> Future<MR>
    
    func getResultFor(reference: String) throws -> Future<MR>
}

public struct Message<T>: MessageRoute where T: TelesignRequest
{
    public typealias MR = T.TR
    private let request: T
    
    init(request: T)
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
        ) throws -> Future<MR>
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
    
    public func getResultFor(reference: String) throws -> Future<MR>
    {
       return try request.get(path: "/v1/messaging/\(reference)")
    }
}
