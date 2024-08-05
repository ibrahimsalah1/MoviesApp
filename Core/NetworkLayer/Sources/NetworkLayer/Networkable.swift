//
//  Networkable.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import Combine

public typealias APIResponse = (data: Data, statusCode: Int)

public protocol Networkable {
    func request(_ endpoint: EndPointRequest) -> AnyPublisher<APIResponse, APIError>
    
    func request<T: Decodable>(
        _ endpoint: EndPointRequest,
        for type: T.Type,
        decoder: JSONDecoder
    ) -> AnyPublisher<T, Error>
    
    func request<T, M: Mappable>(
        _ endpoint: EndPointRequest,
        mapper: M
    ) -> AnyPublisher<T, Error> where M.Output == T
}

public extension Networkable {
    
    func request<T: Decodable>(_ endpoint: EndPointRequest, for type: T.Type) -> AnyPublisher<T, Error> {
        request(endpoint, for: type, decoder: JSONDecoder()).eraseToAnyPublisher()
    }
}
