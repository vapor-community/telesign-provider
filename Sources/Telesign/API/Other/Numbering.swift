//
//  Models.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class Numbering: TelesignResponse
{
    public private(set) var original: Original?
    public private(set) var cleansing: Cleansing?
    
    public init(node: Node) throws
    {
        self.original = try node.get("original")
        self.cleansing = try node.get("cleansing")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
