//
//  BelongsToCollection.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation

struct SpokenLanguage: Decodable {
    let englishName: String?
    let iso6391: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

