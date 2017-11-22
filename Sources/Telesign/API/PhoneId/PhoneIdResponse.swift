//
//  PhoneIdResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/24/17.
//
//

import HTTP

public protocol PhoneIdResponse
{
    var referenceId: String? { get }
    var phoneType: PhoneType? { get }
    var location: Location? { get }
    var numbering: Numbering? { get }
    var carrier: Carrier? { get }
    var status: Status? { get }
}

public struct TelesignPhoneIdResponse: TelesignResponse, PhoneIdResponse
{
    public static var defaultMediaType: MediaType = .json
    
    public var referenceId: String?
    public var phoneType: PhoneType?
    public var location: Location?
    public var numbering: Numbering?
    public var carrier: Carrier?
    public var status: Status?
    
    enum CodingKeys: String, CodingKey
    {
        case referenceId = "reference_id"
        case phoneType = "phone_type"
        case location = "location"
        case numbering = "numbering"
        case carrier = "carrier"
        case status = "status"
    }
}
