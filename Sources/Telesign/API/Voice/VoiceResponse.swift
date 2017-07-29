//
//  VoiceResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/29/17.
//
//

import Foundation
import Vapor

public final class VoiceResponse: TelesignResponse
{
    public private(set) var referenceId: String?
    public private(set) var voice: VoiceLanguage?
    public private(set) var voiceResponse: Node?
    public private(set) var code: Int?
    public private(set) var updatedOn: Date?
    public private(set) var description: String?
    
    public init(node: Node) throws
    {
        self.referenceId = try node.get("reference_id")
        if let v = node["voice"]?.string
        {
            self.voice = VoiceLanguage(rawValue: v)
        }
        if let voice = node["voice"]?.object
        {
            self.voiceResponse = Node(voice)
        }
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
