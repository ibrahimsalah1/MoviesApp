//
//  MovieDetailsView.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import SwiftUI
import DataLayer
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    
    //MARK: - Properties
    
    @ObservedObject private var viewModel: MovieDetailsViewModel

    //MARK: - init
    
    init(dependencies: MovieDetailsViewModel.Dependencies) {
        _viewModel = .init(
            wrappedValue: MovieDetailsViewModel(
                dependencies: dependencies
            )
        )
    }
    
    //MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black
            
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .tint(.white)
                
            case .movie(let movie):
                loadMovieDetails(movie)
                
            case .error(let error):
                Text(error.localizedDescription)
                    .foregroundStyle(.white)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .ignoresSafeArea()
    }
    
    private func loadMovieDetails(_ movie: MovieDetails) -> some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                
                loadCoverImage(url: movie.backdropPath)
                
                VStack {
                    HStack(alignment: .top) {
                        loadPosterImage(url: movie.posterImage)
                       
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(movie.title) (\(movie.releaseDate))")
                            
                            Text(movie.genres)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.white.opacity(0.8))
                        }.padding(.top, 8)
                        
                        Spacer()
                    }
                    
                    Text(movie.overview)
                        .font(.system(size: 14, weight: .regular))
                        .padding(.top)
                    
                }.padding()
                
                VStack(alignment: .leading, spacing: 3) {
                    
                    HStack(alignment: .top) {
                        Text("HomePage:")
                            .font(.system(size: 16, weight: .bold))

                        
                        Text(.init(movie.homepage))
                            .font(.system(size: 16, weight: .regular))
                            .tint(.blue)
                    }
                    
                    loadInfo(for: "Language", value: movie.spokenLanguages)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            loadInfo(for: "Status", value: movie.status)
                            loadInfo(for: "Budget", value: "\(movie.budget)")
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 3) {
                            loadInfo(for: "Runtime", value: "\(movie.runtime)")
                            loadInfo(for: "Revenue", value: "\(movie.revenue)")
                        }
                    }
                
                }.padding(.horizontal)
            }
            .foregroundColor(.white)
        }
    }
    
    private func loadInfo(for name: String, value: String) -> some View {
        MovieDetailsInfoItem(info: .init(title: name, value: value))
    }
    
    private func loadCoverImage(url: URL?) -> some View {
        
        WebImage(url: url) { image in
            image.resizable()
        } placeholder: {
           Image(systemName: "movieclapper")
        }
        .frame(height: 300)
    }
    
    private func loadPosterImage(url: URL?) -> some View {
        
        WebImage(url: url) { image in
            image.resizable()
        } placeholder: {
           Image(systemName: "movieclapper")
        }
        .cornerRadius(10)
        .frame(width: 80, height: 130)
    }
}
