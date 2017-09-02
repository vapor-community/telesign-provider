//
//  TelesignError.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Node
import HTTP

public enum TelesignError: Error
{
    case missingConfig
    
    case missingAPIKey
    
    case missingClientId
    
    case malformedEncodedBody
    
    case connectionError(String,Int)
    
    var localizedDescription: String
    {
        switch self
        {
        case .missingConfig: return "You're missing your configuration file."
            
        case .missingAPIKey: return "You're missing your API Key."
            
        case .missingClientId: return "You're missing your client Id."
        
        case .malformedEncodedBody: return "Got a malformed encoded body. Check your encoded values."
        
        case .connectionError(let description, let code): return "Error code \(code). \(description)"
        }
    }
}
