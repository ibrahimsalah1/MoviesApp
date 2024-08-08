//
//  APIErrorExtension.swift
//
//
//  Created by Ibrahim Salah on 08/08/2024.
//

import Foundation
import NetworkLayer

extension APIError: Equatable {
    
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidEndpoint, .invalidEndpoint),
             (.badServerResponse, .badServerResponse):
            return true
        case (.networkError(let lhsError), .networkError(let rhsError)):
            return "\(lhsError)" == "\(rhsError)"
        case (.parsing(let lhsError), .parsing(let rhsError)):
            return "\(lhsError)" == "\(rhsError)"
        default:
            return false
        }
    }
}
