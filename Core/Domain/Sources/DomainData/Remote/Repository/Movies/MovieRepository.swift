//
//  MovieRepository.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import NetworkLayer
import Domain
import Combine

public final class MoviesRepository: MoviesRepositoryProtocol {
    
    //MARK: - Properties
    
    private let networkService: Networkable
    
    //MARK: - Init
    
    public init(
        networkService: Networkable
    ) {
        self.networkService = networkService
    }
    
    //MARK: - Methods
    
    public func loadGenres() -> AnyPublisher<[Genre], Error> {
        return networkService.request(
            MovieEndPointRequest.loadGenres,
            for: GenresResponse.self
        )
        .map { $0.genres }
        .eraseToAnyPublisher()
    }
    
    public func loadMovies(page: Int) -> AnyPublisher<MoviesPage, Error> {
        networkService.request(
            MovieEndPointRequest.loadMovies(page),
            for: MoviesResponse.self
        ).tryMap { item in
            return try MoviesResponseMapper().map(item)
        }
        .eraseToAnyPublisher()
    }
    
}
