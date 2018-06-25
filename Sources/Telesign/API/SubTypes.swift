//
//  SubTypes.swift
//  Telesign
//
//  Created by Andrew Edwards on 11/19/17.
//

import Foundation

// MARK: Status
public struct Status: TelesignModel {
    /// This code describes the status of your transaction. You can use this code to programmatically respond. You are returned two types of codes, either status codes or error codes.
    var code: Int
    /// A text description of the status code.
    var description: String
    /// This is a timestamp showing when your transaction status was updated last.
    var updatedOn: Date
    
    public enum CodingKeys: String, CodingKey {
        case code
        case description
        case updatedOn = "updated_on"
    }
}

// MARK: Call
public struct Call: TelesignModel {
    /// A 1, 2, or 3-digit number representing the country dialing code. For example, the country dialing code for both the U.S.A. and Canada is 1, and the country dialing code for the United Kingdom is 44.
    var countryCode: String
    /// The base phone number. This is simply the phone number without the country dialing code.
    var phoneNumber: String
    /// One of the phone number cleansing codes describing the cleansing operation TeleSign performed on the phone number. The default value is 100 (No changes were made to the phone number).
    var cleansedCode: Int
    /// The minimum number of digits allowed for phone numbers with this particular country dialing code.
    var minLength: Int
    /// The maximum number of digits allowed for phone numbers with this particular country dialing code.
    var maxLength: Int
    
    public enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
        case cleansedCode = "cleansed_code"
        case minLength = "min_length"
        case maxLength = "max_length"
    }
}

// MARK: Cleansing
public struct Cleansing: TelesignModel {
    /// An object containing cleansing details about a phone number used for receiving voice calls.
    var call: Call
    /// An object containing cleansing details about a phone number used for receiving text messages.
    var sms: SMS
}

// MARK: Coordinates
public struct Coordinates: TelesignModel {
    /// A value indicating the number of degrees of latitude of the location associated with the phone number, expressed in seven decimal digits, with five decimal places. For example, 34.18264.
    var latitude: Double?
    /// A value indicating the number of degrees of longitude of the location associated with the phone number, expressed in eight decimal digits, with five decimal places For example, -118.30840.
    var longitude: Double?
}

// MARK: Country
public struct Country: TelesignModel {
    /// The country name associated with phone number.
    var name: String
    /// The ISO 3166-1 2-letter country code associated with the phone number.
    var iso2: String
    /// The ISO 3166-1 3-letter country code associated with the phone number.
    var iso3: String
}

// MARK: Location
public struct Location: TelesignModel {
    /// A string specifying the name of the city associated with the phone number.
    var city: String
    /// A string specifying the name of the County (or Parish) associated with the phone number (U.S. only).
    var county: String?
    /// The 2-letter state abbreviation code of the state (province, district, or territory) associated with the phone number (North America only).
    var state: String?
    /// The 5-digit United States Postal Service ZIP Code associated with the phone number (U.S. only).
    var zip: String?
    /// A 4-digit string indicating the Primary Metropolitan Statistical Area (PMSA) code for the location associated with the phone number (U.S. only).
    var metroCode: String?
    /// An object containing details about the country associated with the phone number.
    var country: Country
    /// An object containing details about the time zone associated with the phone number.
    var timeZone: Timezone
    /// An object containing details about the geographical coordinates of the location where the phone number is registered.
    var coordinates: Coordinates
    
    public enum CodingKeys: String, CodingKey {
        case city
        case county
        case state
        case zip
        case metroCode = "metro_code"
        case country
        case timeZone = "time_zone"
        case coordinates
    }
}

// MARK: Numbering
public struct Numbering: TelesignModel {
    /// An object containing details about the original phone number passed to TeleSign's PhoneID API.
    var original: Original
    /// An object containing details about how the phone number was cleansed. Phone cleansing corrects common formatting issues in submitted phone numbers.
    var cleansing: Cleansing
}

// MARK: Original
public struct Original: TelesignModel {
    /// The base phone number prefixed with the country dialing code.
    var completePhoneNumber: String
    /// A 1, 2, or 3-digit number representing the country dialing code. For example, the country dialing code for both the U.S.A. and Canada is 1, and the country dialing code for the United Kingdom is 44.
    var countryCode: String
    /// The base phone number. This is simply the phone number without the country dialing code.
    var phoneNumber: String
    
    public enum CodingKeys: String, CodingKey {
        case completePhoneNumber = "complete_phone_number"
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
    }
}

// MARK: Risk
public struct Risk: TelesignModel {
    /// A string indicating the severity of the risk.
    var level: String
    /// A string indicating the action that TeleSign recommends that you take based on the risk score.
    var recommendation: String
    /// One of the scores and risk levels values.
    var score: Int
}

// MARK: SMS
public struct SMS: TelesignModel {
    /// A 1, 2, or 3-digit number representing the country dialing code. For example, the country dialing code for both the U.S.A. and Canada is 1, and the country dialing code for the United Kingdom is 44.
    var countryCode: String
    /// The base phone number. This is simply the phone number without the country dialing code.
    var phoneNumber: String
    /// One of the phone number cleansing codes describing the cleansing operation TeleSign performed on the phone number. The default value is 100 (No changes were made to the phone number).
    var cleansedCode: Int
    /// The minimum number of digits allowed for phone numbers with this particular country dialing code.
    var minLength: Int
    /// The maximum number of digits allowed for phone numbers with this particular country dialing code.
    var maxLength: Int
    
    public enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
        case cleansedCode = "cleansed_code"
        case minLength = "min_length"
        case maxLength = "max_length"
    }
}

// MARK: Timezone
public struct Timezone: TelesignModel {
    /// A string identifying the Time Zone Name (TZ) associated with the phone number (U.S. only). For example: “America/Los_Angeles”.
    var name: String?
    /// For U.S. domestic phone numbers, this parameter returns the UTC offset associated with the phone number. For international phone numbers, this parameter returns the minimum UTC offset for the country associated with the phone number.
    var utcOffsetMin: String
    /// For international phone numbers, this parameter returns the maximum UTC offset for the country associated with the phone number. For U.S. domestic phone numbers, this parameter returns the same result as utc_offset_min.
    var utcOffsetMax: String
    
    public enum CodingKeys: String, CodingKey {
        case name
        case utcOffsetMin = "utc_offset_max"
        case utcOffsetMax = "utc_offset_min"
    }
}

// MARK: Carrier
public struct Carrier: TelesignModel {
    /// A string specifying the name of the carrier. For example: “Verizon”.
    var name: String
}

// MARK: Phonetype
public struct PhoneType: TelesignModel {
    /// One of the phone type codes.
    var code: String
    /// Text describing the phone type.
    var description: String
}
