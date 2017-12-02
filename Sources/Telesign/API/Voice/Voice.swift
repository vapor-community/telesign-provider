//
//  Voice.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/29/17.
//
//

public protocol VoiceRoute
{
    var client: TelesignClient { get }
    
    @discardableResult
    func send(message: String, to recepient: String, messageType: MessageType, voice: VoiceLanguage?, callbackURL: String?, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> VoiceResponse
    
    func getResultFor(reference: String) throws -> VoiceResponse
}

public struct Voice: VoiceRoute
{
    public let client: TelesignClient
    
    init(client: TelesignClient)
    {
        self.client = client
    }
    
    public func send(
        message: String,
        to recepient: String,
        messageType: MessageType,
        voice: VoiceLanguage? = nil,
        callbackURL: String? = nil,
        lifecycleEvent: AccountLifecycleEvent? = nil,
        originatingIp: String? = nil
        ) throws -> VoiceResponse
    {
        var bodyData = [
            "message":message,
            "phone_number": recepient,
            "message_type": messageType.rawValue]

        if let voiceLanguage = voice
        {
            bodyData["voice"] = voiceLanguage.rawValue
        }

        if let callbackurl = callbackURL
        {
            bodyData["callback_url"] = callbackurl
        }

        if let ale = lifecycleEvent
        {
            bodyData["account_lifecycle_event"] = ale.rawValue
        }

        if let ip = originatingIp
        {
            bodyData["originating_ip"] = ip
        }
        
        let request = APIRequest<TelesignVoiceResponseWithLanguage>(client)
        
        try request.post(path: "/v1/voice", body: bodyData)
        
        return try request.serializedResponse()
    }
    
    public func getResultFor(reference: String) throws -> VoiceResponse
    {
        let request = APIRequest<TelesignVoiceResponseWithUserInput>(client)
        
        try request.get(path: "/v1/voice/\(reference)")
        
        return try request.serializedResponse()
    }
}
