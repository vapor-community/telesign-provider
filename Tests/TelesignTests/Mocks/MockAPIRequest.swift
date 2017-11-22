//
//  MockAPIRequest.swift
//  TelesignTests
//
//  Created by Andrew Edwards on 11/19/17.
//

import Foundation
@testable import Telesign
@testable import HTTP

class SpyAPIRequest<T: TelesignResponse>: APIRequest<T>
{
    override func generateHeaders(path: String, method: HTTP.Method, body: [String : String]) throws -> Headers {
        let headers: Headers = [
            Headers.Name.contentType: "json",
        ]
        return headers
    }
}
