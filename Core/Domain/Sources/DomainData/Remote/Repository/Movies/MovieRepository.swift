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
    private let localMoviesRepository: MoviesLocalRepositoryProtocol
    
    //MARK: - Init
    
    public init(
        networkService: Networkable,
        localMoviesRepository: MoviesLocalRepositoryProtocol = MoviesLocalRepository()
    ) {
        self.networkService = networkService
        self.localMoviesRepository = localMoviesRepository
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
            self.localMoviesRepository.save(movies: item, pageIndex: page)
            return try MoviesResponseMapper().map(item)
        }.catch { error -> AnyPublisher<MoviesPage, Error> in
            self.localMoviesRepository.getMovies(for: page)
                .tryMap {
                    try MoviesResponseMapper().map($0)
                }.eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
}
