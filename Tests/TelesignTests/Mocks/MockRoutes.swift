//
//  MockRoutes.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 12/2/17.
//

import Foundation
import Telesign
import Async

struct MockMessageRoute<T>: MessageRoute where T: TelesignRequest
{
    public typealias MR = T.TR
    private let request: T
    
    init(request: T)
    {
        self.request = request
    }
    
    func send(message: String, to recepient: String, messageType: MessageType, callbackURL: String?, lifecycleEvent: AccountLifecycleEvent?, senderId: String?, originatingIp: String?) throws -> Future<MR>
    {
        return try request.post(path: "", body: [:])
    }
    
    func getResultFor(reference: String) throws -> Future<MR>
    {
        return try request.get(path: "")
    }
}

struct MockPhoneRoute<T>: PhoneRoute where T: TelesignRequest
{
    public typealias PIR = T.TR
    private let request: T
    
    init(request: T)
    {
        self.request = request
    }
    
    func getId(for number: String, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> Future<PIR>
    {
        return try request.get(path: "")
    }
}

struct MockScoreRoute<T>: ScoreRoute where T: TelesignRequest
{
    public typealias SR = T.TR
    private let request: T
    
    init(request: T)
    {
        self.request = request
    }
    
    func get(for number: String, lifecycleEvent: AccountLifecycleEvent, originatingIp: String?, deviceId: String?, accountId: String?, emailAddress: String?) throws -> Future<SR>
    {
        return try request.get(path: "")
    }
}

struct MockVoiceRoute<T>: VoiceRoute where T: TelesignRequest
{
    public typealias VR = T.TR
    private let request: T
    
    init(request: T)
    {
        self.request = request
    }
    
    func send(message: String, to recepient: String, messageType: MessageType, voice: VoiceLanguage?, callbackURL: String?, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> Future<VR>
    {
        return try request.post(path: "", body: [:])
    }
    
    func getResultFor(reference: String) throws -> Future<VR>
    {
        return try request.get(path: "")
    }
}
