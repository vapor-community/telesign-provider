//
//  Risk.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class Risk: TelesignResponse
{
    public private(set) var level: String?
    public private(set) var recommendation: String?
    public private(set) var score: Int?
    
    public init(node: Node) throws
    {
        self.level = try node.get("level")
    
        self.recommendation = try node.get("recommendation")
        
        self.score = try node.get("score")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
