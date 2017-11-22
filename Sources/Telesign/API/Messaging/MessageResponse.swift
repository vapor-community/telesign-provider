//
//  MessageResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/21/17.
//
//

import Foundation
import HTTP

public protocol MessageResponse
{
    var referenceId: String? { get }
    var submitTimestamp: Date? { get }
    var status: Status? { get }
}

public struct TelesignMessageResponse: TelesignResponse, MessageResponse
{
    public static var defaultMediaType: MediaType = .json
    
    public var referenceId: String?
    public var submitTimestamp: Date?
    public var status: Status?
    
    enum CodingKeys: String, CodingKey
    {
        case referenceId = "reference_id"
        case submitTimestamp = "submit_timestamp"
        case status = "status"
    }
}
