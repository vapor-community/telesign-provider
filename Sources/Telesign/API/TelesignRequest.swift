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

public protocol TelesignRequest
{
    func post<TR: TelesignResponse>(path: String, body: [String: String]) throws -> Future<TR>
    func get<TR: TelesignResponse>(path: String) throws -> Future<TR>
    func generateHeaders(path: String, method: HTTPMethod, body: [String: String]) throws -> HTTPHeaders
    func serializedResponse<TR: TelesignResponse>(response: HTTPResponse) throws -> Future<TR>
}

extension TelesignRequest
{
    public func post<TR: TelesignResponse>(path: String, body: [String: String]) throws -> Future<TR>
    {
        return try post(path: path, body: body)
    }
    
    public func get<TR: TelesignResponse>(path: String) throws -> Future<TR>
    {
        return try get(path: path)
    }
    
    public func generateHeaders(path: String, method: HTTPMethod, body: [String : String]) throws -> HTTPHeaders
    {
        return try generateHeaders(path: path, method: method, body: body)
    }
    
    public func serializedResponse<TR: TelesignResponse>(response: HTTPResponse) throws -> Future<TR>
    {
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard response.status.code <= 299 else
        {
            let status = try decoder.decode(Status.self, from: response.body).requireCompleted()
            throw TelesignError.connectionError(status.description ?? "Unknown Error", status.code ?? 500)
        }
        
        return try decoder.decode(TR.self, from: response.body)
    }
}

public class APIRequest: TelesignRequest
{
    private let uri = "https://rest-api.telesign.com"
    
    private let apiKey: String
    private let clientId: String
    private let httpClient: Client
    
    init(apiKey: String, clientId: String, httpClient: Client)
    {
        self.apiKey = apiKey
        self.clientId = clientId
        self.httpClient = httpClient
    }
    
    public func post<TR: TelesignResponse>(path: String, body: [String: String]) throws -> Future<TR>
    {
        let queryParams = body.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard var components = URLComponents(string: "")
        else
        {
            throw TelesignError.malformedEncodedBody
        }
        
        components.queryItems =  queryParams
        
        let encodedString = components.url?.absoluteString.replacingOccurrences(of: "?", with: "").removingPercentEncoding ?? ""
        
        let headers = try self.generateHeaders(path: path, method: .post, body: body)
        
        let body = HTTPBody(string: encodedString)
        
        let request = HTTPRequest(method: .post, uri: URI(stringLiteral: uri + path), headers: headers, body: body)
        
        return try httpClient.respond(to: Request(http: request, using: httpClient.container)).flatMap(to: TR.self) { (response) -> Future<TR> in
            
            return try self.serializedResponse(response: response.http)
        }
    }
    
    public func get<TR: TelesignResponse>(path: String) throws -> Future<TR>
    {
        let headers = try generateHeaders(path: path, method: .get, body: [:])
        
        let request = HTTPRequest(method: .get, uri: URI(stringLiteral: uri + path), headers: headers)
        
        return try httpClient.respond(to: Request(http: request, using: httpClient.container)).flatMap(to: TR.self, { (response) -> Future<TR> in
            
            return try self.serializedResponse(response: response.http)
        })
    }
    
    public func generateHeaders(path: String, method: HTTPMethod, body: [String: String]) throws -> HTTPHeaders
    {
        let contentType = (method == .post || method == .put) ? "application/x-www-form-urlencoded" : ""
        
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

        let queryParams = body.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard var components = URLComponents(string: "")
        else
        {
            throw TelesignError.malformedEncodedBody
        }
        
        components.queryItems =  queryParams
        
        let encodedString = components.url?.absoluteString.replacingOccurrences(of: "?", with: "") ?? ""
        
        stringToSignArray.append("\(encodedString)\n")
   
        stringToSignArray.append("\(path)")
        
        let stringToSign = (stringToSignArray.joined(separator: "").removingPercentEncoding ?? "").data(using: .utf8) ?? Data()
        
        let encoder = Base64Encoder(encoding: .base64)
        let decoder = Base64Decoder(encoding: .base64)
        let signature = String(data: try encoder.encode(data: HMAC<SHA256>.authenticate(stringToSign, withKey: decoder.decode(string: apiKey))), encoding: .utf8) ?? ""
        
        let authorization = "TSA \(clientId):\(signature)"
        
        let headers: HTTPHeaders = [
            HTTPHeaders.Key.authorization: authorization,
            HTTPHeaders.Key.contentType: contentType,
            HTTPHeaders.Key("x-ts-date"): "\(date)",
            HTTPHeaders.Key("x-ts-auth-method"): authMethod
        ]
        return headers
    }
}
