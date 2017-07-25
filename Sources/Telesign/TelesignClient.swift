//
//  TelesignClient.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Foundation

public final class TelesignClient
{
    var apiKey: String?
    
    var clientId: String?
    
    public private(set) var messaging: Messaging!
    public private(set) var phoneid: PhoneId!
    public private(set) var score: Score!
    
    init(apiKey: String, clientId: String)
    {
        self.apiKey = apiKey
        
        self.clientId = clientId
    }
    
    func initialize()
    {
        self.messaging = Messaging(client: self)
        self.phoneid = PhoneId(client: self)
        self.score = Score(client: self)
    }
}
