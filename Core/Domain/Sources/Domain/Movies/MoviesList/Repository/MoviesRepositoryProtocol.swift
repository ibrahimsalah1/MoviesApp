//
//  MoviesRepositoryProtocol.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import Combine

public protocol MoviesRepositoryProtocol {
     func loadGenres() -> AnyPublisher<[Genre], Error>
     func loadMovies(page: Int) -> AnyPublisher<MoviesPage, Error>
}
