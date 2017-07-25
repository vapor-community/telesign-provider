//
//  ScoreResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class ScoreResponse: TelesignResponse
{
    public private(set) var referenceId: String?
    public private(set) var phoneType: PhoneType?
    public private(set) var location: Location?
    public private(set) var numbering: Numbering?
    public private(set) var risk: Risk?
    public private(set) var carrier: String?
    public private(set) var code: Int?
    public private(set) var updatedOn: Date?
    public private(set) var description: String?
    
    public init(node: Node) throws
    {
        self.referenceId = try node.get("reference_id")
        
        if let phonetype = node["phone_type"]?.object
        {
            self.phoneType = PhoneType(code: phonetype["code"]?.int, description: phonetype["description"]?.string)
        }
        
        if let status = node["status"]?.object
        {
            self.code = status["code"]?.int
            self.updatedOn = status["updated_on"]?.date
            self.description = status["description"]?.string
        }
        
        self.location = try node.get("location")
        
        self.numbering = try node.get("numbering")
        
        self.risk = try node.get("risk")
        
        if let carrier = node["carrier"]?.object
        {
            self.carrier = carrier["name"]?.string
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
