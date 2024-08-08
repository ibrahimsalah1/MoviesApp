//
//  MovieRepository.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import NetworkLayer
import DataLayer
import Combine

public final class MoviesRepository: MoviesRepositoryProtocol {
    
    //MARK: - Properties
    
    private let networkService: Networkable
    private let localMoviesRepository: LocalMoviesProviderProtocol // Local movies data source
    
    //MARK: - Init
    
    public init(
        networkService: Networkable,
        localMoviesRepository: LocalMoviesProviderProtocol = LocalMoviesProvider()
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
        .map({ [weak self] genres in
            self?.localMoviesRepository.save(genres: genres)
            return genres
        })
        .catch { [weak self] error -> AnyPublisher<[Genre], Error> in
            guard let self  else {
                return Fail(error: error).eraseToAnyPublisher()
            }
            return self.localMoviesRepository.getGenres()
        }
        .eraseToAnyPublisher()
    }
    
    public func loadMovies(page: Int) -> AnyPublisher<MoviesPage, Error> {
        networkService.request(
            MovieEndPointRequest.loadMovies(page),
            for: MoviesResponse.self
        ).tryMap { [weak self] item in
            self?.localMoviesRepository.save(movies: item, pageIndex: page)
            return try MoviesResponseMapper().map(item)
        }.catch { [weak self] error -> AnyPublisher<MoviesPage, Error> in
            guard let self else {
                return Fail(error: error).eraseToAnyPublisher()
            }
            return self.localMoviesRepository.getMovies(for: page)
                .tryMap {
                    try MoviesResponseMapper().map($0)
                }.eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
}
