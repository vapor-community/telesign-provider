//
//  SubTypes.swift
//  Telesign
//
//  Created by Andrew Edwards on 11/19/17.
//

import Foundation
import HTTP

// MARK: Status
public struct Status: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
    var description: String?
    var code: Int?
    var updatedOn: Date?
    
    enum CodingKeys: String, CodingKey
    {
        case code = "code"
        case updatedOn = "updated_on"
        case description = "description"
    }
}

// MARK: Call
public struct Call: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
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
    public static var defaultMediaType: MediaType = .json
    
    var call: Call?
    var sms: SMS?
}

// MARK: Coordinates
public struct Coordinates: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
    var latitude: Double?
    var longitude: Double?
}

// MARK: Country
public struct Country: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
    var name: String?
    var iso2: String?
    var iso3: String?
}

// MARK: Location
public struct Location: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
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
        case city = "city"
        case county = "county"
        case state = "state"
        case zip = "zip"
        case metroCode = "metro_code"
        case country = "country"
        case timezone = "time_zone"
        case coordinates = "coordinates"
    }
}

// MARK: Numbering
public struct Numbering: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
    var original: Original?
    var cleansing: Cleansing?
}

// MARK: Original
public struct Original: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
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
    public static var defaultMediaType: MediaType = .json
    
    var level: String?
    var recommendation: String?
    var score: Int?
}

// MARK: SMS
public struct SMS: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
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
    public static var defaultMediaType: MediaType = .json
    
    var name: String?
    var utcOffsetMin: String?
    var utcOffsetMax: String?
    
    enum CodingKeys: String, CodingKey
    {
        case name = "name"
        case utcOffsetMin = "utc_offset_min"
        case utcOffsetMax = "utc_offset_max"
    }
}

// MARK: Carrier
public struct Carrier: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
    var name: String?
}

// MARK: Phonetype
public struct PhoneType: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
    var code: Int?
    var description: String?
}

// MARK: UserInputResponse
public struct UserInputResponse: TelesignResponse
{
    public static var defaultMediaType: MediaType = .json
    
    var userInput: Int?
    
    enum CodingKeys: String, CodingKey
    {
        case userInput = "user_input"
    }
}
