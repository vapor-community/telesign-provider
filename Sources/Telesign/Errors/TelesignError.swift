//
//  TelesignError.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/20/17.
//
//

import Vapor

public struct TelesignError: TelesignModel, Error, Debuggable {
    public var identifier: String {
        return "\(self.status.code)-\(self.status.description)"
    }
    public var reason: String{
        return self.status.description
    }
    public var status: Status
}
