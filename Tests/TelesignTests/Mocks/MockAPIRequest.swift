//
//  MockAPIRequest.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 11/19/17.
//

import Foundation
import XCTest
@testable import Async
@testable import Telesign
@testable import HTTP

class MockMessageAPIRequest<T: TelesignResponse>: TelesignRequest
{
    var postCalled = false
    var getCalled = false
    
    func post(path: String, body: [String : String]) throws -> Future<T>
    {
        let postJsonData = """
        {
            "reference_id": "0123456789ABCDEF0123456789ABCDEF",
            "status": {
                    "code": 290,
                    "updated_on": "2017-02-01T00:33:34.860418Z",
                    "description": "Message in progress"
                    }
        }
        """.data(using: .utf8)!
        
        let responseBody = HTTPBody(postJsonData)
        
        let model = try serializedResponse(response: HTTPResponse(body: responseBody))
        
        postCalled = true
        
        return Future(model)
    }
    
    func get(path: String) throws -> Future<T>
    {
        let getJsonData = """
        {
        "reference_id": "ABCDEF0123456789ABCDEF0123456789",
        "status": {
           "code": 290,
           "updated_on": "2017-02-01T00:33:34.860418Z",
           "description": "Message in progress"
           }
        }
        """.data(using: .utf8)!
        
        let responseBody = HTTPBody(getJsonData)
        
        let model = try serializedResponse(response: HTTPResponse(body: responseBody))
        
        getCalled = true
        
        return Future(model)
    }
}

class MockPhoneIdAPIRequest<T: TelesignResponse>: TelesignRequest
{
    var postCalled = false
    
    func post(path: String, body: [String: String]) throws -> Future<T>
    {
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
        
        let responseBody = HTTPBody(jsonData)
        
        let model = try serializedResponse(response: HTTPResponse(body: responseBody))
        
        postCalled = true
        
        return Future(model)
    }
    
    func get(path: String) throws -> Future<T>
    {
        throw TelesignError.connectionError("The PhoneId API does not accept get requests!", 500)
    }
}

class MockScoreAPIRequest<T: TelesignResponse>: TelesignRequest
{
    var postCalled = false
    
    func post(path: String, body: [String : String]) throws -> Future<T>
    {
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
        """.data(using: .utf8)!
        
        let responseBody = HTTPBody(jsonData)
        
        let model = try serializedResponse(response: HTTPResponse(body: responseBody))
        
        postCalled = true
        
        return Future(model)
    }
    
    func get(path: String) throws -> Future<T>
    {
        throw TelesignError.connectionError("The Score API does not accept get requests!", 500)
    }
}

class MockVoiceAPIRequest<T: TelesignResponse>: TelesignRequest
{
    var postCalled = false
    var getCalled = false
    
    func post(path: String, body: [String : String]) throws -> Future<T>
    {
        let postJsonData = """
        {
            "reference_id": "0123456789ABCDEF0123456789ABCDEF",
            "status": {
                    "code": 103,
                    "updated_on": "2017-02-01T00:33:34.860418Z",
                    "description": "Message in progress"
            },
            "voice": "f-en-GB"
        }
        """.data(using: .utf8)!
        
        let responseBody = HTTPBody(postJsonData)
        
        let model = try serializedResponse(response: HTTPResponse(body: responseBody))
        
        postCalled = true
        
        return Future(model)
    }
    
    func get(path: String) throws -> Future<T>
    {
        let getJsonData = """
        {
        "reference_id": "ABCDEF0123456789ABCDEF0123456789",
        "status": {
           "code": 290,
           "updated_on": "2017-02-01T00:33:34.860418Z",
           "description": "Message in progress"
           },
        "voice": {
            "user_input": "6"
            }
        }
        """.data(using: .utf8)!
        
        let responseBody = HTTPBody(getJsonData)
        
        let model = try serializedResponse(response: HTTPResponse(body: responseBody))
        
        getCalled = true
        
        return Future(model)
    }
}
