//
//  Original.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class Original: TelesignResponse
{
    public private(set) var completePhoneNumber: String?
    public private(set) var countryCode: String?
    public private(set) var phoneNumber: String?
    
    public init(node: Node) throws
    {
        self.completePhoneNumber = try node.get("complete_phone_number")
        self.countryCode = try node.get("country_code")
        self.phoneNumber = try node.get("phone_number")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
