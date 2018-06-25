//
//  VoiceRoute.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/29/17.
//
//

import Async

public protocol VoiceRoute {
    @discardableResult
    func send(message: String, to recepient: String, messageType: MessageType, voice: VoiceLanguage?, callbackURL: String?, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> Future<TelesignVoiceResponse>
    func getResultFor(reference: String) throws -> Future<TelesignVoiceResponse>
}

public struct Voice: VoiceRoute {
    private var request: TelesignRequest
    
    init(request: TelesignRequest) {
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
        ) throws -> Future<TelesignVoiceResponse> {
        var bodyData = [
            "message":message,
            "phone_number": recepient,
            "message_type": messageType.rawValue]

        if let voiceLanguage = voice {
            bodyData["voice"] = voiceLanguage.rawValue
        }

        if let callbackurl = callbackURL {
            bodyData["callback_url"] = callbackurl
        }

        if let ale = lifecycleEvent {
            bodyData["account_lifecycle_event"] = ale.rawValue
        }

        if let ip = originatingIp {
            bodyData["originating_ip"] = ip
        }
        
        return try request.send(method: .POST, path: "/v1/voice", body: bodyData)
    }
    
    public func getResultFor(reference: String) throws -> Future<TelesignVoiceResponse> {
        return try request.send(method: .GET, path: "/v1/voice/\(reference)")
    }
}
