//
//  MockMessageRoute.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 12/2/17.
//

import Foundation
import Telesign

struct MockMessageRoute: MessageRoute
{
    var request: APIRequest<TelesignMessageResponse>
    
    init(request: APIRequest<TelesignMessageResponse>)
    {
        self.request = request
    }
    
    func send(message: String, to recepient: String, messageType: MessageType, callbackURL: String?, lifecycleEvent: AccountLifecycleEvent?, senderId: String?, originatingIp: String?) throws -> MessageResponse
    {
        return try request.serializedResponse()
    }
    
    func getResultFor(reference: String) throws -> MessageResponse
    {
        return try request.serializedResponse()
    }
}

struct MockPhoneRoute: PhoneRoute
{
    var request: APIRequest<TelesignPhoneIdResponse>
    
    init(request: APIRequest<TelesignPhoneIdResponse>)
    {
        self.request = request
    }
    
    func getId(for number: String, lifecycleEvent: AccountLifecycleEvent?, originatingIp: String?) throws -> PhoneIdResponse
    {
        return try request.serializedResponse()
    }
}

struct MockScoreRoute: ScoreRoute
{
    var request: APIRequest<TelesignScoreResponse>
    
    init(request: APIRequest<TelesignScoreResponse>)
    {
        self.request = request
    }
    
    func get(for number: String, lifecycleEvent: AccountLifecycleEvent, originatingIp: String?, deviceId: String?, accountId: String?, emailAddress: String?) throws -> ScoreResponse
    {
        return try request.serializedResponse()
    }
}

// TODO: - Implement Voice
