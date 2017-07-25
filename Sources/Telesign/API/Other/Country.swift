//
//  Country.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class Country: TelesignResponse
{
    public private(set) var name: String?
    public private(set) var iso2: String?
    public private(set) var iso3: String?
    
    
    public init(node: Node) throws
    {
        self.name = try node.get("name")
        self.iso2 = try node.get("iso2")
        self.iso3 = try node.get("iso3")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
