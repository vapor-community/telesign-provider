//
//  MessageResponse.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/21/17.
//
//

public protocol MessageResponse
{
    var referenceId: String? { get }
    var status: Status? { get }
}

public struct TelesignMessageResponse: TelesignResponse, MessageResponse
{
    public var referenceId: String?
    public var status: Status?
}
