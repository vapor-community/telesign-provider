//
//  ScoreTests.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import XCTest
@testable import Telesign
@testable import Vapor

class ScoreTests: XCTestCase {
    func testGetPhoneReturnsAProperModel() throws {
        let mockRequest = MockAPIRequest()
        let headers: HTTPHeaders = ["Content-Type": MediaType.json.description]
        
        let responseBody = HTTPBody(string: jsonData)
        
        let model = try mockRequest.serializedResponse(response: HTTPResponse(headers: headers, body: responseBody), worker: EmbeddedEventLoop()) as Future<TelesignScoreResponse>
        
        model.do { (scoreResponse) in
            
            XCTAssertNotNil(scoreResponse, "Response response was nil")
            
            XCTAssertNotNil(scoreResponse.referenceId, "Reference Id is nil")
            
            XCTAssertNotNil(scoreResponse.status, "Status is nil")
            
            XCTAssertNotNil(scoreResponse.status.code, "Status code is nil")
            
            XCTAssertNotNil(scoreResponse.status.updatedOn, "Status updated on is nil")
            
            XCTAssertNotNil(scoreResponse.status.description, "Status description is nil")
            
            XCTAssertNotNil(scoreResponse.numbering, "Numbering is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.original, "Numbering original is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.original.completePhoneNumber, "Numbering original complete phone numnber is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.original.countryCode, "Numbering original country code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.original.phoneNumber, "Numbering original phone numnber is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing, "Numbering cleansing is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.call, "Numbering cleansing call is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.call.countryCode, "Numbering cleansing call country code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.call.phoneNumber, "Numbering cleansing call phone number is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.call.cleansedCode, "Numbering cleansing call cleansed code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.call.minLength, "Numbering cleansing call min length is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.call.maxLength, "Numbering cleansing call max length is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.sms, "Numbering cleansing sms is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.sms.countryCode, "Numbering cleansing sms country code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.sms.phoneNumber, "Numbering cleansing sms phone number is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.sms.cleansedCode, "Numbering cleansing sms cleansed code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.sms.minLength, "Numbering cleansing sms min length is nil")
            
            XCTAssertNotNil(scoreResponse.numbering.cleansing.sms.maxLength, "Numbering cleansing sms max length is nil")
            
            XCTAssertNotNil(scoreResponse.phoneType, "PhoneType is nil")
            
            XCTAssertNotNil(scoreResponse.phoneType.code, "PhoneType code is nil")
            
            XCTAssertNotNil(scoreResponse.phoneType.description, "PhoneType description is nil")
            
            XCTAssertNotNil(scoreResponse.location, "Location is nil")
            
            XCTAssertNotNil(scoreResponse.location.city, "Location city is nil")
            
            XCTAssertNil(scoreResponse.location.state, "Location state is not nil")
            
            XCTAssertNil(scoreResponse.location.zip, "Location zip is not nil")
            
            XCTAssertNil(scoreResponse.location.metroCode, "Location metro code is not nil")
            
            XCTAssertNil(scoreResponse.location.county, "Location county is not nil")
            
            XCTAssertNotNil(scoreResponse.location.country, "Location country is nil")
            
            XCTAssertNotNil(scoreResponse.location.country.name, "Location country name is nil")
            
            XCTAssertNotNil(scoreResponse.location.country.iso2, "Location country iso2 is nil")
            
            XCTAssertNotNil(scoreResponse.location.country.iso3, "Location country iso3 is nil")
            
            XCTAssertNotNil(scoreResponse.location.coordinates, "Location coordinates is nil")
            
            XCTAssertNil(scoreResponse.location.coordinates.latitude, "Location coordinates latitude is not nil")
            
            XCTAssertNil(scoreResponse.location.coordinates.longitude, "Location coordinates longitude is not nil")
            
            XCTAssertNotNil(scoreResponse.location.timeZone, "Location timezone is nil")
            
            XCTAssertNil(scoreResponse.location.timeZone.name, "Location timezone name is not nil")
            
            XCTAssertNotNil(scoreResponse.location.timeZone.utcOffsetMin, "Location timezone offsetmin is nil")
            
            XCTAssertNotNil(scoreResponse.location.timeZone.utcOffsetMax, "Location timezone offsetmax is nil")
            
            XCTAssertNotNil(scoreResponse.carrier, "Carrier is nil")
            
            XCTAssertNotNil(scoreResponse.carrier.name, "Carrier name is nil")
            
            XCTAssertNotNil(scoreResponse.risk, "Risk is nil")
            
            XCTAssertNotNil(scoreResponse.risk.level, "Risk level is nil")
            
            XCTAssertNotNil(scoreResponse.risk.recommendation, "Risk recommendation is nil")
            
            XCTAssertNotNil(scoreResponse.risk.score, "Risk score is nil")
            
            }.catch { (error) in
                XCTFail("\(error)")
        }
    }
    
    let jsonData = """
        {
           "reference_id": "B567DC5D1180011C8952823CF6B40773",
           "status": {
              "updated_on": "2017-02-01T00:33:34.860418Z",
              "code": 300,
              "description": "Transaction successfully completed"
           },
           "numbering": {
              "original": {
                 "complete_phone_number": "15555551212",
                 "country_code": "1",
                 "phone_number": "5555551212"
              },
             "cleansing": {
               "call": {
                 "country_code": "1",
                 "phone_number": "5555551212",
                 "cleansed_code": 105,
                 "min_length": 10,
                 "max_length": 10
               },
               "sms": {
                 "country_code": "1",
                 "phone_number": "5555551212",
                 "cleansed_code": 105,
                 "min_length": 10,
                 "max_length": 10
               }
             }
           },
          "phone_type": {
            "code": "8",
            "description": "INVALID"
          },
          "location": {
            "city": "Countrywide",
            "state": null,
            "zip": null,
            "metro_code": null,
            "county": null,
            "country": {
              "name": "United Kingdom",
              "iso2": "GB",
              "iso3": "GBR"
            },
            "coordinates": {
              "latitude": null,
              "longitude": null
            },
            "time_zone": {
              "name": null,
              "utc_offset_min": "0",
              "utc_offset_max": "0"}
          },
          "carrier": {
            "name": "Telefonica UK Limited"
          },
          "risk": {
            "level": "high",
            "recommendation": "block",
            "score": 959
          }
        }
        """
}
