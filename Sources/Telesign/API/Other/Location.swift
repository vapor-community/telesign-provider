//
//  Location.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class Location: TelesignResponse
{
    public private(set) var city: String?
    public private(set) var county: String?
    public private(set) var state: String?
    public private(set) var zip: String?
    public private(set) var country: Country?
    public private(set) var timezone: Timezone?
    public private(set) var coordinates: Coordinates?
    public private(set) var metroCode: String?
    
    public init(node: Node) throws
    {
        self.city = try node.get("city")
        self.county = try node.get("county")
        self.state = try node.get("state")
        self.zip = try node.get("zip")
        self.metroCode = try node.get("metro_code")
        self.country = try node.get("country")
        self.timezone = try node.get("time_zone")
        self.coordinates = try node.get("coordinates")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}

