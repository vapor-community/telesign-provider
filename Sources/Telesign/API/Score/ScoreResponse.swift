//
//  ScoreResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

public protocol ScoreResponse
{
    var referenceId: String? { get }
    var phoneType: PhoneType? { get }
    var location: Location? { get }
    var numbering: Numbering? { get }
    var risk: Risk? { get }
    var carrier: Carrier? { get }
    var status: Status? { get }
}

public struct TelesignScoreResponse: TelesignResponse, ScoreResponse
{
    public var referenceId: String?
    public var phoneType: PhoneType?
    public var location: Location?
    public var numbering: Numbering?
    public var risk: Risk?
    public var carrier: Carrier?
    public var status: Status?
    
    enum CodingKeys: String, CodingKey
    {
        case referenceId = "reference_id"
        case phoneType = "phone_type"
        case location
        case numbering
        case risk
        case carrier
        case status
    }
}
