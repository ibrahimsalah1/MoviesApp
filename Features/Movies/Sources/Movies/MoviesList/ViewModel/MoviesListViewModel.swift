//
//  MoviesListViewModel.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import Domain
import Combine

enum MoviesListUIState {
    case loading, movies(items: [Movie]), error(error: Error)
}

public final class MoviesListViewModel: ObservableObject {
    
    //MARK: - Properties
    
    let moviesRepository: MoviesRepositoryProtocol
    private var movies = [Movie]()
    @Published private(set) var state: MoviesListUIState = .loading
    @Published var genres: [Genre] = []
    @Published var selectedGenreId = -1
    @Published var searchText = ""
    private var isFetchingMoreMovies = false
    private var hasNextPage = false
    private var page = 1
    var cancellableBag = Set<AnyCancellable>()
    
    //MARK: - init
    
    public init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
        loadData()
    }
    
    //MARK: - Methods
    
    private func loadData() {
        loadMovies()
        loadGenres()
    }
    
    private func loadMovies() {
        isFetchingMoreMovies = true
        moviesRepository.loadMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.state = .error(error: error)
                    self.isFetchingMoreMovies = false
                }
            } receiveValue: { movies in
                self.movies.append(contentsOf: movies)
                print(self.movies)
                self.filter()
                self.isFetchingMoreMovies = false
            }
            .store(in: &cancellableBag)
    }
    
    
    func loadMoreMovies() {
        guard !isFetchingMoreMovies else { return }
        page += 1
        loadMovies()
    }
    
    private func loadGenres() {
        moviesRepository.loadGenres()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { genres in
                self.genres = genres
            }
            .store(in: &cancellableBag)
        
    }
    
    func filter() {
        let movies = filterMovies(movies: movies)
        let searchMovies = searchMovies(movies: movies)
        state = .movies(items: searchMovies)
    }
    
    private func filterMovies(movies: [Movie]) -> [Movie] {
        if (selectedGenreId == -1) {
            return movies
        } else {
            return movies.filter({ $0.genreIds.contains(selectedGenreId) })
        }
    }
    
    private func searchMovies(movies: [Movie]) -> [Movie] {
        guard !searchText.isEmpty else {
            return movies
        }
        return movies.filter({ $0.title.lowercased().contains(searchText.lowercased()) })
    }
    
}
