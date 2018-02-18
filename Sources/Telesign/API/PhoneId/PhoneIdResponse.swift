//
//  PhoneIdResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/24/17.
//
//

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
    public var referenceId: String?
    public var phoneType: PhoneType?
    public var location: Location?
    public var numbering: Numbering?
    public var carrier: Carrier?
    public var status: Status?
}
