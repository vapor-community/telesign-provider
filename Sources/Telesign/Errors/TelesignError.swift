//
//  TelesignError.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor

public struct TelesignError: TelesignModel, Error, Debuggable {
    // TODO: - Finish implementing.
    public var identifier: String
    public var reason: String
}
