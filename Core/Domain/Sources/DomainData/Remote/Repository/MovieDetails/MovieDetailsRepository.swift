//
//  MovieDetailsRepository.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import Combine
import Domain
import NetworkLayer

public final class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    
    //MARK: - Properties
    
    private let networkService: Networkable
    
    //MARK: - Init
    
    public init(
        networkService: Networkable
    ) {
        self.networkService = networkService
    }
    
    //MARK: - Methods
    
    public func loadMoviesDetails(id: Int) -> AnyPublisher<MovieDetails, Error> {
        networkService.request(
            MovieEndPointRequest.loadMovieDetails(id),
            mapper: MovieDetailsMapper()
        )
        .eraseToAnyPublisher()
    }
    
}
