//
//  MockMoviesRepository.swift
//
//
//  Created by Ibrahim Salah on 07/08/2024.
//

import Foundation
import DataLayer
import NetworkLayer
import Combine

final class MockMoviesRepository: MoviesRepositoryProtocol {
    
    //MARK: - Methods
    
    func loadMovies(page: Int) -> AnyPublisher<MoviesPage, Error> {
        
        let movies = MoviesMockGenerator.loadMovies()
        return Just(.init(movies: movies, totalPages: 2))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func loadGenres() -> AnyPublisher<[Genre], Error> {

        let genres = GenresMockGenerator.loadGenres()
        return Just(genres)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
