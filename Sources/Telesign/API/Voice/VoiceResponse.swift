//
//  VoiceResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/29/17.
//
//

import Foundation
import HTTP

public protocol VoiceResponse
{
    var referenceId: String? { get }
    var voice: VoiceLanguage? { get }
    var userInputResponse: UserInputResponse? { get }
    var status: Status? { get }
}

public struct TelesignVoiceResponseWithLanguage: TelesignResponse, VoiceResponse
{
    public static var defaultMediaType: MediaType = .json
    
    public var referenceId: String?
    public var voice: VoiceLanguage?
    public var userInputResponse: UserInputResponse?
    public var status: Status?
    
    enum CodingKeys: String, CodingKey
    {
        case referenceId = "reference_id"
        case voice = "voice"
        case userInputResponse = ""
        case status = "status"
    }
}

public struct TelesignVoiceResponseWithUserInput: TelesignResponse, VoiceResponse
{
    public static var defaultMediaType: MediaType = .json
    
    public var referenceId: String?
    public var voice: VoiceLanguage?
    public var userInputResponse: UserInputResponse?
    public var status: Status?
    
    enum CodingKeys: String, CodingKey
    {
        case referenceId = "reference_id"
        case voice = ""
        case userInputResponse = "voice"
        case status = "status"
    }
}
