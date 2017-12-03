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
@testable import HTTP

class ScoreTests: XCTestCase
{
    var scoreRoute: Score!
    
    override func setUp()
    {
        do
        {
            let httpclient = try HTTPClient.connect(to: "https://www.google.com", ssl: false, on: DispatchQueue(label: "test")).blockingAwait()
            
            let mockClient = MockTelesignClient(apiKey: "", clientId: "", client: httpclient)
            
            let mockRequest = MockScoreAPIRequest<TelesignScoreResponse>(mockClient)
            
            scoreRoute = Score(request: mockRequest)
        }
        catch let error as TelesignError
        {
            switch error
            {
            case .malformedEncodedBody:
                XCTFail(error.localizedDescription)
            case .missingAPIKey:
                XCTFail(error.localizedDescription)
            case .missingClientId:
                XCTFail(error.localizedDescription)
            case .missingConfig:
                XCTFail(error.localizedDescription)
            case .connectionError(_):
                XCTFail(error.localizedDescription)
            }
        }
        catch
        {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testGetPhoneReturnsAProperModel() throws
    {
        let response = try scoreRoute.get(for: "", lifecycleEvent: .create)
        
        XCTAssertTrue((scoreRoute.request as? MockScoreAPIRequest)?.postCalled ?? false)
        
        XCTAssertNotNil(response, "Response response was nil")
        
        XCTAssertNotNil(response.referenceId, "Reference Id is nil")
        
        XCTAssertNotNil(response.status, "Status is nil")
        
        XCTAssertNotNil(response.status?.code, "Status code is nil")
        
        XCTAssertNotNil(response.status?.updatedOn, "Status updated on is nil")
        
        XCTAssertNotNil(response.status?.description, "Status description is nil")
        
        XCTAssertNotNil(response.numbering, "Numbering is nil")
        
        XCTAssertNotNil(response.numbering?.original, "Numbering original is nil")
        
        XCTAssertNotNil(response.numbering?.original?.completePhoneNumber, "Numbering original complete phone numnber is nil")
        
        XCTAssertNotNil(response.numbering?.original?.countryCode, "Numbering original country code is nil")
        
        XCTAssertNotNil(response.numbering?.original?.phoneNumber, "Numbering original phone numnber is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing, "Numbering cleansing is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.call, "Numbering cleansing call is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.call?.countryCode, "Numbering cleansing call country code is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.call?.phoneNumber, "Numbering cleansing call phone number is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.call?.cleansedCode, "Numbering cleansing call cleansed code is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.call?.minLength, "Numbering cleansing call min length is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.call?.maxLength, "Numbering cleansing call max length is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.sms, "Numbering cleansing sms is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.sms?.countryCode, "Numbering cleansing sms country code is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.sms?.phoneNumber, "Numbering cleansing sms phone number is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.sms?.cleansedCode, "Numbering cleansing sms cleansed code is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.sms?.minLength, "Numbering cleansing sms min length is nil")
        
        XCTAssertNotNil(response.numbering?.cleansing?.sms?.maxLength, "Numbering cleansing sms max length is nil")
        
        XCTAssertNotNil(response.phoneType, "PhoneType is nil")
        
        XCTAssertNotNil(response.phoneType?.code, "PhoneType code is nil")
        
        XCTAssertNotNil(response.phoneType?.description, "PhoneType description is nil")
        
        XCTAssertNotNil(response.location, "Location is nil")
        
        XCTAssertNotNil(response.location?.city, "Location city is nil")
        
        XCTAssertNil(response.location?.state, "Location state is not nil")
        
        XCTAssertNil(response.location?.zip, "Location zip is not nil")
        
        XCTAssertNil(response.location?.metroCode, "Location metro code is not nil")
        
        XCTAssertNil(response.location?.county, "Location county is not nil")
        
        XCTAssertNotNil(response.location?.country, "Location country is nil")
        
        XCTAssertNotNil(response.location?.country?.name, "Location country name is nil")
        
        XCTAssertNotNil(response.location?.country?.iso2, "Location country iso2 is nil")
        
        XCTAssertNotNil(response.location?.country?.iso3, "Location country iso3 is nil")
        
        XCTAssertNotNil(response.location?.coordinates, "Location coordinates is nil")
        
        XCTAssertNil(response.location?.coordinates?.latitude, "Location coordinates latitude is not nil")
        
        XCTAssertNil(response.location?.coordinates?.longitude, "Location coordinates longitude is not nil")
        
        XCTAssertNotNil(response.location?.timezone, "Location timezone is nil")
        
        XCTAssertNil(response.location?.timezone?.name, "Location timezone name is not nil")
        
        XCTAssertNotNil(response.location?.timezone?.utcOffsetMin, "Location timezone offsetmin is nil")
        
        XCTAssertNotNil(response.location?.timezone?.utcOffsetMax, "Location timezone offsetmax is nil")
        
        XCTAssertNotNil(response.carrier, "Carrier is nil")
        
        XCTAssertNotNil(response.carrier?.name, "Carrier name is nil")
        
        XCTAssertNotNil(response.risk, "Risk is nil")
        
        XCTAssertNotNil(response.risk?.level, "Risk level is nil")
        
        XCTAssertNotNil(response.risk?.recommendation, "Risk recommendation is nil")
        
        XCTAssertNotNil(response.risk?.score, "Risk score is nil")
    }
}

