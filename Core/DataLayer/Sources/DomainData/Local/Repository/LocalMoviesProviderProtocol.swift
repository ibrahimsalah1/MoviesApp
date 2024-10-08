//
//  LocalMoviesProviderProtocol.swift
//
//
//  Created by Ibrahim Salah on 07/08/2024.
//

import Foundation
import DataLayer
import Combine

public protocol LocalMoviesProviderProtocol {
    
    func getMovies(for pageIndex: Int) -> AnyPublisher<MoviesResponse, Error>
    func save(movies: MoviesResponse, pageIndex: Int)
    
    func getGenres() -> AnyPublisher<[Genre], Error>
    func save(genres: [Genre])
}
