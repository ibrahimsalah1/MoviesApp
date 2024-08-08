//
//  MoviesListViewModel.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import DataLayer
import Combine

public final class MoviesListViewModel: ObservableObject {
    
    enum MoviesListUIState {
        case loading, movies(items: [Movie]), error(error: Error)
    }
    
    //MARK: - Properties
    
    let moviesRepository: MoviesRepositoryProtocol
    private var movies = [Movie]()
    private var isFetchingMoreMovies = false
    private var page = 1
    private var totalPages = 1
    var cancellableBag = Set<AnyCancellable>()
    
    //MARK: - UI Properties
    
    @Published private(set) var state: MoviesListUIState = .loading
    @Published var genres: [Genre] = []
    
    @Published var selectedGenreId = -1 {
        willSet {
            let movies = filterSearch(
                movies: movies,
                withGenreId: newValue,
                andSearchText: searchText
            )
            state = .movies(items: movies)
        }
    }
    
    @Published var searchText = "" {
        willSet {
            let movies = filterSearch(
                movies: movies,
                withGenreId: selectedGenreId,
                andSearchText: newValue
            )
            state = .movies(items: movies)
        }
    }
    
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
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished: break
                case .failure(let error):
                    state = .error(error: error)
                    isFetchingMoreMovies = false
                }
            } receiveValue: { [weak self] moviesPage in
                guard let self else { return }
                totalPages = moviesPage.totalPages
                movies.append(contentsOf: moviesPage.movies)
                state = .movies(
                    items:
                        filterSearch(
                            movies: movies,
                            withGenreId: selectedGenreId,
                            andSearchText: searchText
                        )
                )
                isFetchingMoreMovies = false
            }
            .store(in: &cancellableBag)
    }
    
    
    func loadMoreMovies() {
        guard !isFetchingMoreMovies,
              totalPages > page
        else { return }
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
    
    private func filterSearch(
        movies: [Movie],
        withGenreId genreId: Int,
        andSearchText searchText: String
    ) -> [Movie] {
        let filteredMovies = filterMovies(
            movies: movies,
            withGenreId: genreId
        )
        let searchMovies = searchMovies(
            movies: filteredMovies,
            withSearchText: searchText
        )
        return searchMovies
    }
    
    private func filterMovies(
        movies: [Movie],
        withGenreId genreId: Int
    ) -> [Movie] {
        if (genreId == -1) {
            return movies
        } else {
            return movies.filter({
                $0.genreIds.contains(genreId)
            })
        }
    }
    
    private func searchMovies(
        movies: [Movie],
        withSearchText searchText: String
    ) -> [Movie] {
        guard !searchText.isEmpty else {
            return movies
        }
        
        return movies.filter({
            $0.title.lowercased().contains(searchText.lowercased())
        })
    }
    
}
