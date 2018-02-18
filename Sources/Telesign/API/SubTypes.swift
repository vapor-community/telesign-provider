//
//  SubTypes.swift
//  Telesign
//
//  Created by Andrew Edwards on 11/19/17.
//

import Foundation

// MARK: Status
public struct Status: TelesignResponse
{
    var description: String?
    var code: Int?
    var updatedOn: Date?
}

// MARK: Call
public struct Call: TelesignResponse
{
    var countryCode: String?
    var phoneNumber: String?
    var cleansedCode: Int?
    var minLength: Int?
    var maxLength: Int?
}

// MARK: Cleansing
public struct Cleansing: TelesignResponse
{
    var call: Call?
    var sms: SMS?
}

// MARK: Coordinates
public struct Coordinates: TelesignResponse
{
    var latitude: Double?
    var longitude: Double?
}

// MARK: Country
public struct Country: TelesignResponse
{
    var name: String?
    var iso2: String?
    var iso3: String?
}

// MARK: Location
public struct Location: TelesignResponse
{
    var city: String?
    var county: String?
    var state: String?
    var zip: String?
    var metroCode: String?
    var country: Country?
    var timeZone: Timezone?
    var coordinates: Coordinates?
}

// MARK: Numbering
public struct Numbering: TelesignResponse
{
    var original: Original?
    var cleansing: Cleansing?
}

// MARK: Original
public struct Original: TelesignResponse
{
    var completePhoneNumber: String?
    var countryCode: String?
    var phoneNumber: String?
}

// MARK: Risk
public struct Risk: TelesignResponse
{
    var level: String?
    var recommendation: String?
    var score: Int?
}

// MARK: SMS
public struct SMS: TelesignResponse
{
    var countryCode: String?
    var phoneNumber: String?
    var cleansedCode: Int?
    var minLength: Int?
    var maxLength: Int?
}

// MARK: Timezone
public struct Timezone: TelesignResponse
{
    var name: String?
    var utcOffsetMin: String?
    var utcOffsetMax: String?
}

// MARK: Carrier
public struct Carrier: TelesignResponse
{
    var name: String?
}

// MARK: Phonetype
public struct PhoneType: TelesignResponse
{
    var code: String?
    var description: String?
}
