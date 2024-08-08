//
//  EndPointRequest.swift
//
//
//  Created by Ibrahim Salah on 05/08/2024.
//

import Foundation

public protocol EndPointRequest {
    var baseURL: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }
}

public extension EndPointRequest {
    
    var baseURL: URL? { nil }
    
    var headers: [String: String]? { nil }
    
    var queryParameters: [String: String]? { nil }
}

