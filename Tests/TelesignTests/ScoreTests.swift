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

class ScoreTests: XCTestCase
{
    var scoreRoute: Score<MockScoreAPIRequest<TelesignScoreResponse>>!
    
    override func setUp()
    {
        let mockRequest = MockScoreAPIRequest<TelesignScoreResponse>()
        
        scoreRoute = Score(request: mockRequest)
    }
    
    func testGetPhoneReturnsAProperModel() throws
    {
        let response = try scoreRoute.get(for: "", lifecycleEvent: .create)
        
        response.do { (scoreResponse) in
            
            XCTAssertNotNil(scoreResponse, "Response response was nil")
            
            XCTAssertNotNil(scoreResponse.referenceId, "Reference Id is nil")
            
            XCTAssertNotNil(scoreResponse.status, "Status is nil")
            
            XCTAssertNotNil(scoreResponse.status?.code, "Status code is nil")
            
            XCTAssertNotNil(scoreResponse.status?.updatedOn, "Status updated on is nil")
            
            XCTAssertNotNil(scoreResponse.status?.description, "Status description is nil")
            
            XCTAssertNotNil(scoreResponse.numbering, "Numbering is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.original, "Numbering original is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.original?.completePhoneNumber, "Numbering original complete phone numnber is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.original?.countryCode, "Numbering original country code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.original?.phoneNumber, "Numbering original phone numnber is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing, "Numbering cleansing is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.call, "Numbering cleansing call is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.call?.countryCode, "Numbering cleansing call country code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.call?.phoneNumber, "Numbering cleansing call phone number is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.call?.cleansedCode, "Numbering cleansing call cleansed code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.call?.minLength, "Numbering cleansing call min length is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.call?.maxLength, "Numbering cleansing call max length is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.sms, "Numbering cleansing sms is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.sms?.countryCode, "Numbering cleansing sms country code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.sms?.phoneNumber, "Numbering cleansing sms phone number is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.sms?.cleansedCode, "Numbering cleansing sms cleansed code is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.sms?.minLength, "Numbering cleansing sms min length is nil")
            
            XCTAssertNotNil(scoreResponse.numbering?.cleansing?.sms?.maxLength, "Numbering cleansing sms max length is nil")
            
            XCTAssertNotNil(scoreResponse.phoneType, "PhoneType is nil")
            
            XCTAssertNotNil(scoreResponse.phoneType?.code, "PhoneType code is nil")
            
            XCTAssertNotNil(scoreResponse.phoneType?.description, "PhoneType description is nil")
            
            XCTAssertNotNil(scoreResponse.location, "Location is nil")
            
            XCTAssertNotNil(scoreResponse.location?.city, "Location city is nil")
            
            XCTAssertNil(scoreResponse.location?.state, "Location state is not nil")
            
            XCTAssertNil(scoreResponse.location?.zip, "Location zip is not nil")
            
            XCTAssertNil(scoreResponse.location?.metroCode, "Location metro code is not nil")
            
            XCTAssertNil(scoreResponse.location?.county, "Location county is not nil")
            
            XCTAssertNotNil(scoreResponse.location?.country, "Location country is nil")
            
            XCTAssertNotNil(scoreResponse.location?.country?.name, "Location country name is nil")
            
            XCTAssertNotNil(scoreResponse.location?.country?.iso2, "Location country iso2 is nil")
            
            XCTAssertNotNil(scoreResponse.location?.country?.iso3, "Location country iso3 is nil")
            
            XCTAssertNotNil(scoreResponse.location?.coordinates, "Location coordinates is nil")
            
            XCTAssertNil(scoreResponse.location?.coordinates?.latitude, "Location coordinates latitude is not nil")
            
            XCTAssertNil(scoreResponse.location?.coordinates?.longitude, "Location coordinates longitude is not nil")
            
            XCTAssertNotNil(scoreResponse.location?.timezone, "Location timezone is nil")
            
            XCTAssertNil(scoreResponse.location?.timezone?.name, "Location timezone name is not nil")
            
            XCTAssertNotNil(scoreResponse.location?.timezone?.utcOffsetMin, "Location timezone offsetmin is nil")
            
            XCTAssertNotNil(scoreResponse.location?.timezone?.utcOffsetMax, "Location timezone offsetmax is nil")
            
            XCTAssertNotNil(scoreResponse.carrier, "Carrier is nil")
            
            XCTAssertNotNil(scoreResponse.carrier?.name, "Carrier name is nil")
            
            XCTAssertNotNil(scoreResponse.risk, "Risk is nil")
            
            XCTAssertNotNil(scoreResponse.risk?.level, "Risk level is nil")
            
            XCTAssertNotNil(scoreResponse.risk?.recommendation, "Risk recommendation is nil")
            
            XCTAssertNotNil(scoreResponse.risk?.score, "Risk score is nil")
            
            }.catch { (error) in
                XCTFail(error.localizedDescription)
        }
    }
}


