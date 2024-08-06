//
//  BelongsToCollection.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation

struct BelongsToCollection: Decodable {
    
    let id: Int
    let name: String
    let posterPath: String
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
