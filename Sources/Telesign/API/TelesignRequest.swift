//
//  TelesignRequest.swift
//  Telesign
//
//  Created by Andrew Edwards on 7/21/17.
//
//

import Foundation
import Vapor
import HTTP
import TCP
import Async
import Crypto

public protocol TelesignRequest
{
    associatedtype T: TelesignResponse
    
    var response: HTTPResponse! { get }
    var telesignClient: TelesignClient { get }
    
    func post(path: String, body: [String: String]) throws
    func get(path: String) throws
    func generateHeaders(path: String, method: HTTPMethod, body: [String: String]) throws -> HTTPHeaders
    func serializedResponse() throws -> T
}

public class APIRequest<T: TelesignResponse>: TelesignRequest
{
    private let uri = "https://rest-api.telesign.com"
    
    public var response: HTTPResponse!
    
    public let telesignClient: TelesignClient

    init(_ client: TelesignClient)
    {
        telesignClient = client
    }
    
    public func post(path: String, body: [String: String]) throws
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
        
        self.response = try telesignClient.httpClient.send(request: request).blockingAwait()
    }
    
    public func get(path: String) throws
    {
        let headers = try generateHeaders(path: path, method: .get, body: [:])
        
        let request = HTTPRequest(method: .get, uri: URI(stringLiteral: uri + path), headers: headers)
        
        self.response = try telesignClient.httpClient.send(request: request).blockingAwait()
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
        
        let signature = try Base64Encoder.encode(data: HMAC<SHA256>.authenticate(stringToSign, withKey: Base64Decoder.decode(string: telesignClient.apiKey)))
        //(.sha256, stringToSign.makeBytes(), key: Base64Encoder.decode(telesignClient.apiKey.makeBytes()))).makeString()
        
        let authorization = "TSA \(telesignClient.clientId):\(signature)"
        
        let headers: HTTPHeaders = [
            HTTPHeaders.Name.authorization: authorization,
            HTTPHeaders.Name.contentType: contentType,
            HTTPHeaders.Name("x-ts-date"): "\(date)",
            HTTPHeaders.Name("x-ts-auth-method"): authMethod
        ]
        
        return headers
    }
    
    // TODO: - Add multiple serializedresponses based on date formats until Telesign unifies their API.
    @discardableResult
    public func serializedResponse() throws -> T
    {
        let decoder = JSONDecoder()
        
        guard response.status.code <= 299 else
        {
            let status = try decoder.decode(Status.self, from: response.body.data ?? Data())
            
            throw TelesignError.connectionError(status.description ?? "Unknown Error", status.code ?? 500)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss z"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return try decoder.decode(T.self, from: response.body.data ?? Data())
    }
}
