//
//  Coordinates.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class Coordinates: TelesignResponse
{
    public private(set) var lat: Double?
    public private(set) var lng: Double?
    
    public init(node: Node) throws
    {
        self.lat = try node.get("latitude")
        self.lng = try node.get("longitude")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
