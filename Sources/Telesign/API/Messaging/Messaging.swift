//
//  Messaging.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor

public final class Messaging
{
    let client: TelesignClient
    
    init(client: TelesignClient)
    {
        self.client = client
    }
    
    @discardableResult
    public func send(message: String, to recepient: String, messageType: MessageType, callbackUrl: String?, lifecycleEvent: AccountLifecycleEvent?, senderId: String?, originatingIp: String?) throws -> MessageResponse
    {
        var body = Node([:])
        
        body["message"] = Node(message)
        
        body["phone_number"] = Node(recepient)
        
        body["message_type"] = Node(messageType.rawValue)
        
        if let callbackurl = callbackUrl
        {
            body["callback_url"] = Node(callbackurl)
        }
        
        if let ale = lifecycleEvent
        {
            body["account_lifecycle_event"] = Node(ale.rawValue)
        }
        
        if let senderId = senderId
        {
            body["sender_id"] = Node(senderId)
        }
        
        if let ip = originatingIp
        {
            body["originating_ip"] = Node(ip)
        }
        
        let request = TelesignRequest<MessageResponse>(client: self.client)
        
        try request.post(path: "/v1/messaging", body: body)
        
        return try request.serializedResponse()
    }
    
    public func getResultFor(reference: String) throws -> MessageResponse
    {
        let request = TelesignRequest<MessageResponse>(client: self.client)
        
        try request.get(path: "/v1/messaging/\(reference)")
        
        return try request.serializedResponse()
    }
}
