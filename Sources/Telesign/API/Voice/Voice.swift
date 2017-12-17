//
//  Voice.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/29/17.
//
//

import Async

public protocol VoiceRoute
{
    associatedtype VR: TelesignResponse
    
    @discardableResult
    func send(message: String, to recepient: String, messageType: MessageType, voice: VoiceLanguage?, callbackURL: String?, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> Future<VR>
    
    func getResultFor(reference: String) throws -> Future<VR>
}

public struct Voice<T>: VoiceRoute where T: TelesignRequest
{
    public typealias VR = T.TR
    private var request: T
    
    init(request: T)
    {
        self.request = request
    }
    
    @discardableResult
    public func send(
        message: String,
        to recepient: String,
        messageType: MessageType,
        voice: VoiceLanguage? = nil,
        callbackURL: String? = nil,
        lifecycleEvent: AccountLifecycleEvent? = nil,
        originatingIp: String? = nil
        ) throws -> Future<VR>
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
        
        return try request.post(path: "/v1/voice", body: bodyData)
    }
    
    public func getResultFor(reference: String) throws -> Future<VR>
    {
        return try request.get(path: "/v1/voice/\(reference)")
    }
}
