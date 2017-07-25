//
//  MessageResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/21/17.
//
//

import Foundation
import Vapor

public final class MessageResponse: TelesignResponse
{
    public private(set) var referenceId: String?
    public private(set) var submitTimestamp: Date?
    public private(set) var code: Int?
    public private(set) var updatedOn: Date?
    public private(set) var description: String?
    
    public init(node: Node) throws
    {
        self.referenceId = try node.get("reference_id")
        self.submitTimestamp = try node.get("submit_timestamp")
        if let status = node["status"]?.object
        {
            self.code = status["code"]?.int
            self.updatedOn = status["updated_on"]?.date
            self.description = status["description"]?.string
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
