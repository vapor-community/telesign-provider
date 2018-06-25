//
//  TelesignRequest.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/21/17.
//
//

import Foundation
import Vapor
import Crypto

public protocol TelesignRequest {
    var apiKey: String { get set}
    var clientId: String { get set}
    func send<TM: TelesignModel>(method: HTTPMethod, path: String, body: [String: String]?) throws -> Future<TM>
    func generateHeaders(path: String, method: HTTPMethod, body: [String: String]?) throws -> HTTPHeaders
    func serializedResponse<TM: TelesignModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<TM>
}

extension TelesignRequest {
    public func send<TR: TelesignModel>(method: HTTPMethod, path: String, body: [String: String]? = nil) throws -> Future<TR> {
        return try send(method: method, path: path, body: body)
    }
    
    public func generateHeaders(path: String, method: HTTPMethod, body: [String: String]?) throws -> HTTPHeaders {
        let contentType = (method == .POST || method == .PUT) ? "application/x-www-form-urlencoded" : ""
        
        let authMethod = "HMAC-SHA256"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss z"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = formatter.string(from: Date())
        
        var stringToSignArray = [
            "\(method.string)\n",
            "\(contentType)\n",
            "\n",
            "x-ts-auth-method:\(authMethod)\n",
            "x-ts-date:\(date)\n"]
        
        if let body = body {
            stringToSignArray.append("\(body.queryParameters)\n")
        }
        
        stringToSignArray.append("\(path)")
        
        let stringToSign = (stringToSignArray.joined(separator: "").removingPercentEncoding ?? "").convertToData()
        
        let signature = try HMAC(algorithm: .sha256).authenticate(stringToSign, key: apiKey.convertToData().convert(to: String.self)).base64EncodedString()
        
        let authorization = "TSA \(clientId):\(signature)"
        
        let headers: HTTPHeaders = [
            HTTPHeaderName.authorization.description: authorization,
            HTTPHeaderName.contentType.description: contentType,
            HTTPHeaders.Key("x-ts-date"): "\(date)",
            HTTPHeaders.Key("x-ts-auth-method"): authMethod
        ]
        return headers
    }
    
    public func serializedResponse<TM: TelesignModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<TM> {
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard response.status.code <= 299 else {
            return try decoder.decode(TelesignError.self, from: response, maxSize: 65_536, on: worker).map(to: TM.self) { error in
                throw error
            }
        }
        return try decoder.decode(TM.self, from: response, maxSize: 65_536, on: worker)
    }
}

public class APIRequest: TelesignRequest {
    private let uri = "https://rest-api.telesign.com"
    
    public var apiKey: String
    public var clientId: String
    let httpClient: Client
    
    init(apiKey: String, clientId: String, httpClient: Client) {
        self.apiKey = apiKey
        self.clientId = clientId
        self.httpClient = httpClient
    }
    
    public func send<TM: TelesignModel>(method: HTTPMethod, path: String, body: [String: String]? = nil) throws -> Future<TM> {
        var requestBody: [String: String] = [:]
        if let body = body {
             requestBody = body
        }

        let headers = try self.generateHeaders(path: path, method: method, body: requestBody)
        
        return httpClient.send(method, headers: headers, to: "\(uri)\(path)") { (request) in
            request.http.body = HTTPBody(string: requestBody.queryParameters)
            }.flatMap(to: TM.self, { (response) -> Future<TM> in
            return try self.serializedResponse(response: response.http, worker: self.httpClient.container.eventLoop)
        })
    }
}
