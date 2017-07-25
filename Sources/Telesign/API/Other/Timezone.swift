//
//  Timezone.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class Timezone: TelesignResponse
{
    public private(set) var name: String?
    public private(set) var utcOffsetMin: String?
    public private(set) var utcOffsetMax: String?
    
    public init(node: Node) throws
    {
        self.name = try node.get("name")
        self.utcOffsetMin = try node.get("utc_offset_min")
        self.utcOffsetMax = try node.get("utc_offset_max")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
