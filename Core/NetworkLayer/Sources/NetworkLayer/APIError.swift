//
//  APIError.swift
//
//
//  Created by Ibrahim Salah on 05/08/2024.
//

import Foundation

public enum APIError: Error {
    case invalidEndpoint
    case badServerResponse
    case networkError(error: Error)
    case parsing(error: Error)
}
