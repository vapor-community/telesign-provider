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
    
    var response: Response! { get }
    var httpClient: HTTPClient! { get }
    var telesignClient: TelesignClient { get }
    
    func post(path: String, body: [String: String]) throws
    func get(path: String) throws
    func generateHeaders(path: String, method: HTTP.Method, body: [String: String]) throws -> Headers
    func serializedResponse() throws -> T
}

public class APIRequest<T: TelesignResponse>: TelesignRequest
{
    public var httpClient: HTTPClient!
    
    private let uri = "https://rest-api.telesign.com"
    
    public var response: Response!
    
    public let telesignClient: TelesignClient

    init(_ client: TelesignClient)
    {
        telesignClient = client
        
        //httpClient = try HTTPClient(tcp: TCPClient(socket: Socket(), worker: DispatchQueue(label: "telesign")))
        //let socket = try Socket()

        //try socket.connect(hostname: uri, port: 443)
        
        //let client = TCPClient(socket: socket, worker: DispatchQueue(label: "telesign"))

        
//        httpClient = socket.writable(queue: DispatchQueue(label: "telesign")).map {
//
//
//            client.start()
//
//            return HTTPClient(tcp: client)
//        }
    }
    
    public func post(path: String, body: [String: String]) throws
    {
        //let headers = try self.generateHeaders(path: path, method: .post, body: body)
        
        //var finalBody: BodyRepresentable? = nil
        
        let queryParams = body.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard var components = URLComponents(string: "")
        else
        {
            throw TelesignError.malformedEncodedBody
        }
        
        components.queryItems =  queryParams
        
        _ = components.url?.absoluteString.replacingOccurrences(of: "?", with: "").removingPercentEncoding ?? ""
        
        //finalBody = Body.data(encodedString.makeBytes())
        
        //self.response = try self.httpClient.post(uri + path, query: [:], headers, finalBody, through: [])
    }
    
    public func get(path: String) throws
    {
        let headers = try generateHeaders(path: path, method: .get, body: [:])
        
       // self.response = try self.httpClient.send(request: <#T##RequestRepresentable#>)//get(uri + path, query: [:], headers, nil, through: [])
    }
    
    public func generateHeaders(path: String, method: HTTP.Method, body: [String: String]) throws -> Headers
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
        
        let headers: Headers = [
            Headers.Name.authorization: authorization,
            Headers.Name.contentType: contentType,
            Headers.Name("x-ts-date"): "\(date)",
            Headers.Name("x-ts-auth-method"): authMethod
        ]
        
        return headers
    }
    
    @discardableResult
    public func serializedResponse() throws -> T
    {
        let decoder = JSONDecoder()
        
        guard response.status.code <= 299 else
        {
            let status = try decoder.decode(Status.self, from: response.body)
            
            throw TelesignError.connectionError(status.description ?? "Unknown Error", status.code ?? 500)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss z"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return try decoder.decode(T.self, from: response.body)
    }
}
