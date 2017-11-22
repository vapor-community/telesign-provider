//
//  TelesignClient.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Foundation

public protocol TelesignClient
{
    var apiKey: String { get }
    var clientId: String { get }
    
    var messaging: MessageRoute! { get }
    var phoneid: PhoneRoute! { get }
    var score: ScoreRoute! { get }
    var voice: VoiceRoute! { get }
    
    init(apiKey: String, clientId: String)
    
    mutating func initialize()
}

public struct TClient: TelesignClient
{
    public var apiKey: String
    public var clientId: String
    
    public var messaging: MessageRoute!
    public var phoneid: PhoneRoute!
    public var score: ScoreRoute!
    public var voice: VoiceRoute!
    
    public init(apiKey: String, clientId: String)
    {
        self.apiKey = apiKey
        self.clientId = clientId
    }
    
    public mutating func initialize()
    {
        self.messaging = Message(request: APIRequest<TelesignMessageResponse>(self))
        self.phoneid = Phone(client: self)
        self.score = Score(client: self)
        self.voice = Voice(client: self)
    }
}
