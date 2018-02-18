//
//  PhoneIdTests.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/24/17.
//
//

import XCTest

@testable import Telesign
@testable import Vapor

class PhoneIdTests: XCTestCase
{
    func testGetPhoneIdReturnsAProperModel() throws
    {
        let mockRequest = MockAPIRequest()
        
        let responseBody = HTTPBody(jsonData)
        
        let model = try mockRequest.serializedResponse(response: HTTPResponse(body: responseBody)) as Future<TelesignPhoneIdResponse>
        
        model.do { (phoneResponse) in
            
            XCTAssertNotNil(phoneResponse, "Response response was nil")
            
            XCTAssertNotNil(phoneResponse.referenceId, "Reference Id is nil")
            
            XCTAssertNotNil(phoneResponse.status, "Status is nil")
            
            XCTAssertNotNil(phoneResponse.status?.code, "Status code is nil")
            
            XCTAssertNotNil(phoneResponse.status?.updatedOn, "Status updated on is nil")
            
            XCTAssertNotNil(phoneResponse.status?.description, "Status description is nil")
            
            XCTAssertNotNil(phoneResponse.location, "Location is nil")
            
            XCTAssertNotNil(phoneResponse.location?.city, "Location city is nil")
            
            XCTAssertNotNil(phoneResponse.location?.state, "Location state is nil")
            
            XCTAssertNotNil(phoneResponse.location?.zip, "Location zip is nil")
            
            XCTAssertNotNil(phoneResponse.location?.metroCode, "Location metro code is nil")
            
            XCTAssertNotNil(phoneResponse.location?.county, "Location county is nil")
            
            XCTAssertNotNil(phoneResponse.location?.country, "Location country is nil")
            
            XCTAssertNotNil(phoneResponse.location?.country?.name, "Location country name is nil")
            
            XCTAssertNotNil(phoneResponse.location?.country?.iso2, "Location country iso2 is nil")
            
            XCTAssertNotNil(phoneResponse.location?.country?.iso3, "Location country iso3 is nil")
            
            XCTAssertNotNil(phoneResponse.location?.coordinates, "Location coordinates is nil")
            
            XCTAssertNotNil(phoneResponse.location?.coordinates?.latitude, "Location coordinates latitude is nil")
            
            XCTAssertNotNil(phoneResponse.location?.coordinates?.longitude, "Location coordinates longitude is nil")
            
            XCTAssertNotNil(phoneResponse.location?.timeZone, "Location timezone is nil")
            
            XCTAssertNotNil(phoneResponse.location?.timeZone?.name, "Location timezone name is nil")
            
            XCTAssertNotNil(phoneResponse.location?.timeZone?.utcOffsetMin, "Location timezone offsetmin is nil")
            
            XCTAssertNotNil(phoneResponse.location?.timeZone?.utcOffsetMax, "Location timezone offsetmax is nil")
            
            XCTAssertNotNil(phoneResponse.numbering, "Numbering is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.original, "Numbering original is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.original?.completePhoneNumber, "Numbering original complete phone numnber is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.original?.countryCode, "Numbering original country code is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.original?.phoneNumber, "Numbering original phone numnber is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing, "Numbering cleansing is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.call, "Numbering cleansing call is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.call?.countryCode, "Numbering cleansing call country code is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.call?.phoneNumber, "Numbering cleansing call phone number is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.call?.cleansedCode, "Numbering cleansing call cleansed code is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.call?.minLength, "Numbering cleansing call min length is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.call?.maxLength, "Numbering cleansing call max length is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.sms, "Numbering cleansing sms is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.sms?.countryCode, "Numbering cleansing sms country code is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.sms?.phoneNumber, "Numbering cleansing sms phone number is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.sms?.cleansedCode, "Numbering cleansing sms cleansed code is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.sms?.minLength, "Numbering cleansing sms min length is nil")
            
            XCTAssertNotNil(phoneResponse.numbering?.cleansing?.sms?.maxLength, "Numbering cleansing sms max length is nil")
            
            XCTAssertNotNil(phoneResponse.phoneType, "PhoneType is nil")
            
            XCTAssertNotNil(phoneResponse.phoneType?.code, "PhoneType code is nil")
            
            XCTAssertNotNil(phoneResponse.phoneType?.description, "PhoneType description is nil")
            
            XCTAssertNotNil(phoneResponse.carrier, "Carrier is nil")
            
            XCTAssertNotNil(phoneResponse.carrier?.name, "Carrier name is nil")
            
            }.catch { (error) in
                XCTFail(error.localizedDescription)
        }
    }
    
    let jsonData = """
        {
           "reference_id": "F0123456789ABCDEF0123456789ABCDE",
           "status": {
              "updated_on": "2017-02-01T00:33:34.860418Z",
              "code": 300,
              "description": "Transaction successfully completed"
           },
           "location": {
              "city": "Los Angeles",
              "state": "CA",
              "zip": "90066",
              "metro_code": "4480",
              "county": "Los Angeles County",
              "country": {
                 "name": "United States",
                 "iso2": "US",
                 "iso3": "USA"
              },
              "coordinates": {
                 "latitude": 33.99791,
                 "longitude": -118.42302
              },
              "time_zone": {
                 "name": "America/Los_Angeles",
                 "utc_offset_min": "-8",
                 "utc_offset_max": "-8"
              }
           },
           "numbering": {
              "original": {
                 "complete_phone_number": "15555551234",
                 "country_code": "1",
                 "phone_number": "5555551234"
              },
              "cleansing": {
                 "call": {
                    "country_code": "1",
                    "phone_number": "5555551234",
                    "cleansed_code": 100,
                    "min_length": 10,
                    "max_length": 10
                 },
                 "sms": {
                    "country_code": "1",
                    "phone_number": "5555551234",
                    "cleansed_code": 100,
                    "min_length": 10,
                    "max_length": 10
                 }
              }
           },
           "phone_type": {
              "code": "1",
              "description": "FIXED_LINE"
           },
           "carrier": {
              "name": "Verizon"
           }
        }
        """.data(using: .utf8)!
}
