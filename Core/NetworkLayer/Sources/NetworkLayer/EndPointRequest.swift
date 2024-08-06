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
    
    var baseURL: URL? {
        URL(string: "https://api.themoviedb.org")
    }
    
    var headers: [String: String]? {
        [
            "content-type": "application/json",
            "accept": "application/json",
            "api-key": "39d1fa0cee839b46028fc750816055e6",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOWQxZmEwY2VlODM5YjQ2MDI4ZmM3NTA4MTYwNTVlNiIsIm5iZiI6MTcyMjUzNzAxMC43MDY5MTYsInN1YiI6IjVlNDVjM2U2ZGI4YTAwMDAxMjliOGJhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6D4KmBTmEjGDQBMl-zxKz8-i1aCanwwFzTjZ55odlVA"
        ]
    }
    
    var queryParameters: [String: String]? { nil }
}

