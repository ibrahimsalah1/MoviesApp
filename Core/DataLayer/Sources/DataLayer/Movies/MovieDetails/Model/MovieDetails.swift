//
//  MovieDetails.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation

public struct MovieDetails: Equatable, Hashable, Identifiable {
    
    //MARK: - Properties
    
    public let id: Int
    public let backdropPath: URL?
    public let posterImage: URL?
    public let budget: String
    public let genres: String
    public let homepage: String
    public let overview: String
    public let releaseDate: String
    public let revenue: String
    public let runtime: String
    public let spokenLanguages: String
    public let status: String
    public let title: String
    
    //MARK: - init
    
    public init(
        id: Int,
        backdropPath: URL?,
        posterImage: URL?,
        budget: String,
        genres: String,
        homepage: String,
        overview: String,
        releaseDate: String,
        revenue: String,
        runtime: String,
        spokenLanguages: String,
        status: String,
        title: String
    ) {
        self.backdropPath = backdropPath
        self.posterImage = posterImage
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.overview = overview
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.title = title
    }
}
