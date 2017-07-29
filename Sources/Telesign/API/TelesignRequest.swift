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
import Crypto

internal enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

public final class TelesignRequest<T: TelesignResponse>
{
    private let uri = "https://rest-api.telesign.com"
    
    var response: HTTP.Response!
    
    let httpClient = EngineClient.factory
    
    let telesignClient: TelesignClient

    init(client: TelesignClient)
    {
        self.telesignClient = client
    }
    
    func post(path: String, body: Node?) throws
    {
        let headers = try self.generateHeaders(path: path, method: .post, body: body)
        
        var finalBody: BodyRepresentable? = nil
        
        if let body = body?.object
        {
            let queryParams = body.map { URLQueryItem(name: $0.key, value: $0.value.string ?? "") }
            
            guard var components = URLComponents(string: "")
            else
            {
                throw TelesignError.malformedEncodedBody
            }
            
            components.queryItems =  queryParams
            
            let encodedString = components.url?.absoluteString.replacingOccurrences(of: "?", with: "").removingPercentEncoding ?? ""
            
            finalBody = Body.data(encodedString.makeBytes())
        }
        
        self.response = try self.httpClient.post(uri + path, query: [:], headers, finalBody, through: [])
    }
    
    func get(path: String) throws
    {
        let headers = try self.generateHeaders(path: path, method: .get, body: nil)
        
        self.response = try self.httpClient.get(uri + path, query: [:], headers, nil, through: [])
    }
    
    func generateHeaders(path: String, method: HTTPMethod, body: Node?) throws -> [HeaderKey: String]
    {
        let contentType = (method == .post || method == .put) ? "application/x-www-form-urlencoded" : ""
        
        let authMethod = "HMAC-SHA256"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss z"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = formatter.string(from: Date())
        
        var stringToSignArray = [
            "\(method.rawValue)\n",
            "\(contentType)\n",
            "\n",
            "x-ts-auth-method:\(authMethod)\n",
            "x-ts-date:\(date)\n"]
        
        if let body = body?.object
        {
            let queryParams = body.map { URLQueryItem(name: $0.key, value: $0.value.string ?? "") }
            
            guard var components = URLComponents(string: "")
            else
            {
                throw TelesignError.malformedEncodedBody
            }
            
            components.queryItems =  queryParams
            
            let encodedString = components.url?.absoluteString.replacingOccurrences(of: "?", with: "") ?? ""
            
            stringToSignArray.append("\(encodedString)\n")
        }
        
        stringToSignArray.append("\(path)")
        
        let stringToSign = stringToSignArray.joined(separator: "").removingPercentEncoding ?? ""
        
        guard let apikey = self.telesignClient.apiKey else
        {
            throw TelesignError.missingAPIKey
        }
    
        guard let clientId = self.telesignClient.clientId else
        {
            throw TelesignError.missingClientId
        }
        
        let signature = try Base64Encoder().encode(HMAC.make(.sha256, stringToSign.makeBytes(), key: Base64Encoder().decode(apikey.makeBytes()))).makeString()
        
        let authorization = "TSA \(clientId):\(signature)"
        
        let headers: [HeaderKey: String] = [
            HeaderKey.authorization: authorization,
            HeaderKey.contentType: contentType,
            HeaderKey("x-ts-date"): "\(date)",
            HeaderKey("x-ts-auth-method"): authMethod
        ]
        
        return headers
    }
    
    @discardableResult
    public func serializedResponse() throws -> T
    {
        guard self.response.status.statusCode <= 299 else
        {
            throw TelesignError.connectionError(self.response.status)
        }
        
        guard let value = self.response.json else { throw TelesignError.malformedEncodedBody }
        
        return try T(node: value)
    }
}
