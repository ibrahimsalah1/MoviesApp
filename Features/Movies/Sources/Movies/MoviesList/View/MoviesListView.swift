//
//  MoviesListView.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import SwiftUI
import Domain
import DomainData
import Router

public struct MoviesListView: View {
    
    //MARK: - Properties
    
    @ObservedObject private var viewModel: MoviesListViewModel
    @EnvironmentObject private var router: Router

    //MARK: - Init
    
    init(repository: MoviesRepositoryProtocol) {
        _viewModel = .init(wrappedValue: MoviesListViewModel(moviesRepository: repository))
    }
    
    //MARK: - Body
    
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .tint(.white)
                
            case .movies(let movies):
                VStack(alignment: .leading) {
                    
                    loadHeaderText()
                    
                    MovieGenresView(
                        genres: viewModel.genres,
                        selectedGenres: $viewModel.selectedGenreId
                    )
                    .onChange(of: $viewModel.selectedGenreId.wrappedValue) { genreId in
                        viewModel.filter()
                    }
                    
                    loadMoviesList(movies)
                        .padding(.horizontal, 20)
                }
                
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText)
        .foregroundStyle(.white)
        .accentColor(.white)
        .onChange(of: $viewModel.searchText.wrappedValue) { value in
            viewModel.filter()
        }
        
    }
    
    //MARK: - Methods
    
    private func loadHeaderText() -> some View{
        Text("Watch New Movies")
            .font(.system(size: 23, weight: .bold))
            .foregroundColor(.init(hex: "#CFA614"))
            .padding(.horizontal, 20)
    }
    
    private func loadMoviesList(_ movies: [Movie]) -> some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<movies.count, id: \.self) { index in
                    MovieItemView(movie: movies[index])
                        .onTapGesture {
                            router.navigate(to: Destination.movieDetail(movie: movies[index]))
                        }
                        .onAppear {
                            if index == (movies.count - 1) {
                                viewModel.loadMoreMovies()
                            }
                        }
                }
            }
        }
    }
}
