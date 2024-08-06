//
//  MovieDetailsViewModel.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import Domain
import Combine

public final class MovieDetailsViewModel: ObservableObject {
    
    struct Dependencies {
        let movie: Movie
        let movieDetailRepository: MovieDetailsRepositoryProtocol
    }
    
    enum MovieDetailsUIState {
        case loading, movie(movie: MovieDetails), error(error: Error)
    }
    
    //MARK: - Properties
    
    private let moviesRepository: MovieDetailsRepositoryProtocol
    private let movie: Movie
    @Published private(set) var state: MovieDetailsUIState = .loading
    var cancellableBag = Set<AnyCancellable>()
    
    //MARK: - init
    
    init(dependencies: Dependencies) {
        self.movie = dependencies.movie
        moviesRepository = dependencies.movieDetailRepository
        loadData()
    }
    
    //MARK: - Methods
    
    private func loadData() {
        moviesRepository.loadMoviesDetails(id: movie.id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.state = .error(error: error)
                }
            } receiveValue: { [weak self] details in
                self?.state = .movie(movie: details)
            }
            .store(in: &cancellableBag)
    }
}

