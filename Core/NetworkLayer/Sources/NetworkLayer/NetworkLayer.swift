//
//  NetworkLayer.swift
//
//
//  Created by Ibrahim Salah on 05/08/2024.
//

import Foundation
import Combine


final public class NetworkService: Networkable {
    
    public struct Configuration {
        let baseURL: URL?
        let baseHeaders: [String: String]

        public init(baseURL: URL?, baseHeaders: [String: String]) {
            self.baseURL = baseURL
            self.baseHeaders = baseHeaders
        }

        public static let `default` = Configuration(baseURL: nil, baseHeaders: [:])
    }
    
    //MARK: - Properties
    
    private let configuration: Configuration
    
    //MARK: - init
    
    public init(configuration: Configuration = .default) {
        self.configuration = configuration
    }
    
    //MARK: - Methods
    
    public func request(_ endpoint: EndPointRequest) -> AnyPublisher<APIResponse, APIError> {
        guard let request = getURLRequest(from: endpoint) else {
            return Fail(error: APIError.invalidEndpoint).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200 ..< 400).contains(httpResponse.statusCode) else {
                    throw APIError.badServerResponse
                }
                return (data, httpResponse.statusCode)
            }
            .mapError { error in
                (error as? APIError) ?? APIError.networkError(error: error)
            }
            .eraseToAnyPublisher()
    }
    
    public func request<T>(
        _ endpoint: EndPointRequest,
        for type: T.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, Error> where T: Decodable {
        
         request(endpoint)
            .tryMap { apiResponse in
                do {
                    return try decoder.decode(T.self, from: apiResponse.data)
                } catch {
                    throw APIError.parsing(error: error)
                }
            }
            .mapError { error in
                (error as? APIError) ?? APIError.parsing(error: error)
            }
            .eraseToAnyPublisher()
    }
    
    public func request<T, M: Mappable>(
        _ endpoint: EndPointRequest,
        mapper: M
    ) -> AnyPublisher<T, Error> where T == M.Output {
        
         request(endpoint, for: M.Input.self)
            .tryMap { input in
                do {
                    return try mapper.map(input)
                } catch {
                    throw APIError.parsing(error: error)
                }
            }
            .mapError { error in
                (error as? APIError) ?? APIError.parsing(error: error)
            }
            .eraseToAnyPublisher()
    }
    
    private func getURLRequest(from endpoint: EndPointRequest) -> URLRequest? {
        let host = endpoint.baseURL?.host ?? configuration.baseURL?.host
        guard let host = host else { return nil }

        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = endpoint.path

        if let urlQueries = endpoint.queryParameters {
            var queryItems: [URLQueryItem] = []
            for item in urlQueries {
                queryItems.append(
                    URLQueryItem(
                        name: item.key,
                        value: item.value
                    )
                )
            }
            components.queryItems = queryItems
        }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        
        let endpointHeaders = endpoint.headers ?? [:]
            .merging(configuration.baseHeaders) { (_, headers) in headers }
        request.allHTTPHeaderFields = endpointHeaders
        request.httpMethod = endpoint.httpMethod.rawValue
        return request
    }
}
