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
    
    enum CodingKeys: String, CodingKey
    {
        case code
        case updatedOn = "updated_on"
        case description
    }
}

// MARK: Call
public struct Call: TelesignResponse
{
    var countryCode: String?
    var phoneNumber: String?
    var cleansedCode: Int?
    var minLength: Int?
    var maxLength: Int?
    
    enum CodingKeys: String, CodingKey
    {
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
        case cleansedCode = "cleansed_code"
        case minLength = "min_length"
        case maxLength = "max_length"
    }
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
    var timezone: Timezone?
    var coordinates: Coordinates?
    
    enum CodingKeys: String, CodingKey
    {
        case city
        case county
        case state
        case zip
        case metroCode = "metro_code"
        case country
        case timezone = "time_zone"
        case coordinates
    }
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
    
    enum CodingKeys: String, CodingKey
    {
        case completePhoneNumber = "complete_phone_number"
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
    }
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
    
    enum CodingKeys: String, CodingKey
    {
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
        case cleansedCode = "cleansed_code"
        case minLength = "min_length"
        case maxLength = "max_length"
    }
}

// MARK: Timezone
public struct Timezone: TelesignResponse
{
    var name: String?
    var utcOffsetMin: String?
    var utcOffsetMax: String?
    
    enum CodingKeys: String, CodingKey
    {
        case name
        case utcOffsetMin = "utc_offset_min"
        case utcOffsetMax = "utc_offset_max"
    }
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
