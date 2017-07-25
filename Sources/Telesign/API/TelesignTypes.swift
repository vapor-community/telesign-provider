//
//  TelesignTypes.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/21/17.
//
//

import Foundation

public enum MessageType: String
{
    case OTP
    case ARN
    case MKT
}

public enum AccountLifecycleEvent: String
{
    case create
    case signIn = "sign-in"
    case transact
    case update
    case delete
}
