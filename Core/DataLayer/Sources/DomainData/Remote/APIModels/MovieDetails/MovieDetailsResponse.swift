//
//  MovieDetailsResponse.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import DataLayer
import NetworkLayer

struct MovieDetailsMapper: Mappable {
    
    func map(_ input: MovieDetailsResponse) throws -> MovieDetails {
        return try MovieDetailsResponseMapper().map(input)
    }
}

struct MovieDetailsResponseMapper {
    
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    func map(_ movie: MovieDetailsResponse) throws -> MovieDetails {
        guard let id = movie.id else {
            throw NSError(
                domain: "Movie id not found",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Fetch failed"]
            )
        }
        
        let imageCollection = movie.belongsToCollection
        let languages = movie.spokenLanguages?.map(\.englishName).joined(separator: ", ") ?? ""
        let genres = movie.genres?.map(\.name.rawValue).joined(separator: ", ") ?? ""
        
        return .init(
            id: id,
            backdropPath: URL(string: baseImageURL + (imageCollection?.backdropPath ?? "")),
            posterImage: URL(string: baseImageURL + (imageCollection?.posterPath ?? "")),
            budget: "\(movie.budget ?? 0) $",
            genres: genres,
            homepage: movie.homepage ?? "",
            overview: movie.overview ?? "",
            releaseDate: getYearReleaseDate(for: movie.releaseDate),
            revenue: "\(movie.revenue ?? 0) $",
            runtime: "\(movie.runtime ?? 0) minutes",
            spokenLanguages: languages,
            status: movie.status ?? "",
            title: movie.title ?? ""
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

struct MovieDetailsResponse: Decodable {
    
    //MARK: - Properties
    
    let budget: Int?
    let genres: [Genre]?
    let belongsToCollection: BelongsToCollection?
    let homepage: String?
    let id: Int?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case title
    }
}
