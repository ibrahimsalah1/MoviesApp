//
//  MovieResponse.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import Domain
import NetworkLayer

struct TrendingMovieResponse: Decodable {
    let results: [MovieResponse]
}

struct TrendingMovieResponseMapper: Mappable {
    func map(_ input: TrendingMovieResponse) throws -> [Movie] {
        return try input.results.compactMap { try MovieResponseMapper().map($0) }
    }
}

struct MovieResponse: Decodable {
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
