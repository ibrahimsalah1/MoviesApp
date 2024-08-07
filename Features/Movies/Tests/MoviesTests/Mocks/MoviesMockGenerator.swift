//
//  MoviesMockGenerator.swift
//
//
//  Created by Ibrahim Salah on 07/08/2024.
//

import Foundation
import Domain

final class MoviesMockGenerator {
    
    static func loadMovies() -> [Movie] {
        [
            Movie(
                id: 1,
                title: "Movie 1",
                posterPath: nil,
                genreIds: [1, 2],
                releaseDate: ""
            ),
            Movie(
                id: 2,
                title: "Movie 2",
                posterPath: nil,
                genreIds: [2, 3],
                releaseDate: ""
            ),
            Movie(
                id: 3,
                title: "Movie 3",
                posterPath: nil,
                genreIds: [1, 3],
                releaseDate: ""
            )
        ]
    }
    
}
