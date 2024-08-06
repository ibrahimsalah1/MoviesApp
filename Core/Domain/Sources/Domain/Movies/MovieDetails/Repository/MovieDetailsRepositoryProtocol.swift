//
//  MovieDetailsRepositoryProtocol.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import Combine

public protocol MovieDetailsRepositoryProtocol {
    
     func loadMoviesDetails(id: Int) -> AnyPublisher<MovieDetails, Error>
}
