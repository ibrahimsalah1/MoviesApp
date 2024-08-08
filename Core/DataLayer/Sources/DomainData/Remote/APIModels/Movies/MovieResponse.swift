//
//  MovieResponse.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import DataLayer
import NetworkLayer

public struct MoviesResponse: Codable {
    public var totalPages: Int?
    public let results: [MovieResponse]?
    
    public init(totalPages: Int?, results: [MovieResponse]?) {
        self.totalPages = totalPages
        self.results = results
    }
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
}

struct MoviesResponseMapper: Mappable {
    
    func map(_ input: MoviesResponse) throws -> MoviesPage {
        let movies = try input.results?.compactMap { try MovieResponseMapper().map($0) } ?? []
        return .init(
            movies: movies,
            totalPages: input.totalPages ?? 0
        )
    }
}

public struct MovieResponse: Codable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let genreIds: [Int]?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
    }
}


struct MovieResponseMapper: Mappable {
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    func map(_ movie: MovieResponse) throws -> Movie? {
        guard let movieId = movie.id
        else { return nil }
        return .init(
            id: movieId,
            title: movie.title ?? "",
            posterPath: URL(string: baseImageURL + (movie.posterPath ?? "")),
            genreIds: movie.genreIds ?? [],
            releaseDate: getYearReleaseDate(for: movie.releaseDate)
        )
    }
    
    private func getYearReleaseDate(for date: String?) -> String {
        guard let date else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return "\(year)"
        }
        
        return ""
    }
}
