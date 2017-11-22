//
//  Messaging.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

public protocol MessageRoute
{
    var request: APIRequest<TelesignMessageResponse> { get }
    
    @discardableResult
    func send(message: String, to recepient: String, messageType: MessageType, callbackURL: String?, lifecycleEvent: AccountLifecycleEvent?, senderId: String?, originatingIp: String?) throws -> MessageResponse
    
    func getResultFor(reference: String) throws -> MessageResponse
}

public struct Message: MessageRoute
{
    public var request: APIRequest<TelesignMessageResponse>
    init(request: APIRequest<TelesignMessageResponse>)
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
        ) throws -> MessageResponse
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
        
        try request.post(path: "/v1/messaging", body: bodyData)
        
        return try request.serializedResponse()
    }
    
    public func getResultFor(reference: String) throws -> MessageResponse
    {
        try request.get(path: "/v1/messaging/\(reference)")
        
        return try request.serializedResponse()
    }
}
