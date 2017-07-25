//
//  Cleansing.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/25/17.
//
//

import Foundation
import Vapor

public final class Cleansing: TelesignResponse
{
    public private(set) var call: Call?
    public private(set) var sms: SMS?
    
    public init(node: Node) throws
    {
        self.call = try node.get("call")
        self.sms = try node.get("sms")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        return try Node(node: [:])
    }
}
