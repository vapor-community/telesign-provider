//
//  SMS.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class SMS: TelesignResponse
{
    public private(set) var countryCode: String?
    public private(set) var phoneNumber: String?
    public private(set) var cleansedCode: Int?
    public private(set) var minLength: Int?
    public private(set) var maxLength: Int?
    
    public init(node: Node) throws
    {
        self.countryCode = try node.get("country_code")
        self.phoneNumber = try node.get("phone_number")
        self.cleansedCode = try node.get("cleansed_code")
        self.minLength = try node.get("min_length")
        self.maxLength = try node.get("min_length")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
