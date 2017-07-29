//
//  Voice.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/29/17.
//
//

import Vapor

public final class Voice
{
    let client: TelesignClient
    
    init(client: TelesignClient)
    {
        self.client = client
    }
    
    public func send(message: String, to recepient: String, messageType: MessageType, voice: VoiceLanguage?, callbackUrl: String?, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> VoiceResponse
    {
        var body = Node([:])
        
        body["message"] = Node(message)
        
        body["phone_number"] = Node(recepient)
        
        body["message_type"] = Node(messageType.rawValue)
        
        if let voicetype = voice
        {
            body["voice"] = Node(voicetype.rawValue)
        }
        
        if let callbackurl = callbackUrl
        {
            body["callback_url"] = Node(callbackurl)
        }
        
        if let ale = lifecycleEvent
        {
            body["account_lifecycle_event"] = Node(ale.rawValue)
        }
        
        if let ip = originatingIp
        {
            body["originating_ip"] = Node(ip)
        }
        
        let request = TelesignRequest<VoiceResponse>(client: self.client)
        
        try request.post(path: "/v1/voice", body: body)
        
        return try request.serializedResponse()
    }
    
    public func getResultFor(reference: String) throws -> VoiceResponse
    {
        let request = TelesignRequest<VoiceResponse>(client: self.client)
        
        try request.get(path: "/v1/voice/\(reference)")
        
        return try request.serializedResponse()
    }
}
