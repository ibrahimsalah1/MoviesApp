//
//  MockMoviesRepositoryWithError.swift
//
//
//  Created by Ibrahim Salah on 08/08/2024.
//

import Foundation
import NetworkLayer
import DataLayer
import Combine

final class MockMoviesRepositoryWithError: MoviesRepositoryProtocol {
    
    func loadGenres() -> AnyPublisher<[Genre], Error> {
         Fail(error: APIError.badServerResponse)
            .eraseToAnyPublisher()
    }
    
    func loadMovies(page: Int) -> AnyPublisher<MoviesPage, Error> {
        Fail(error: APIError.badServerResponse)
           .eraseToAnyPublisher()
    }
}
