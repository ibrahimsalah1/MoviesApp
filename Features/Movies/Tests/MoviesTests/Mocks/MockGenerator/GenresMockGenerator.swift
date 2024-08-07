//
//  GenresMockGenerator.swift
//
//
//  Created by Ibrahim Salah on 07/08/2024.
//

import Foundation
import Domain

final class GenresMockGenerator {
    
    static func loadGenres() -> [Genre] {
        [
            Genre(id: 1, name: .action),
            Genre(id: 2, name: .adventure),
            Genre(id: 3, name: .animation)
        ]
    }
    
}
