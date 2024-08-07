//
//  Movie.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation

public struct MoviesPage {
    
    //MARK: - Properties
    
    public let movies: [Movie]
    public let totalPages: Int
    
    //MARK: - init
    
    public init(
        movies: [Movie],
        totalPages: Int
    ) {
        self.movies = movies
        self.totalPages = totalPages
       
    }
}

public struct Movie: Equatable, Hashable, Identifiable {
    
    //MARK: - Properties
    
    public let id: Int
    public let title: String
    public let posterPath: URL?
    public let genreIds: [Int]
    public let releaseDate: String

    //MARK: - init
    
    public init(
        id: Int,
        title: String,
        posterPath: URL?,
        genreIds: [Int],
        releaseDate: String
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.genreIds = genreIds
        self.releaseDate = releaseDate
    }
}
