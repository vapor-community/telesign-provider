//
//  VoiceResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/29/17.
//
//

public protocol VoiceResponse
{
    var referenceId: String? { get }
    var voice: VoiceLanguageOrUserInputResponse? { get }
    var status: Status? { get }
}

public struct TelesignVoiceResponse: TelesignResponse, VoiceResponse
{
    public var referenceId: String?
    public var voice: VoiceLanguageOrUserInputResponse?
    public var status: Status?
    
    enum CodingKeys: String, CodingKey
    {
        case referenceId = "reference_id"
        case voice
        case status
    }
}
