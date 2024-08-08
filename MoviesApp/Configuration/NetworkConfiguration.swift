//
//  NetworkConfiguration.swift
//  MoviesApp
//
//  Created by Ibrahim Salah on 08/08/2024.
//

import Foundation
import NetworkLayer

extension NetworkService.Configuration {
    
    static let networkConfiguration = Self.init(
        baseURL: URL(string: "https://api.themoviedb.org"),
        baseHeaders:  [
            "content-type": "application/json",
            "accept": "application/json",
            "api-key": "39d1fa0cee839b46028fc750816055e6",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOWQxZmEwY2VlODM5YjQ2MDI4ZmM3NTA4MTYwNTVlNiIsIm5iZiI6MTcyMjUzNzAxMC43MDY5MTYsInN1YiI6IjVlNDVjM2U2ZGI4YTAwMDAxMjliOGJhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6D4KmBTmEjGDQBMl-zxKz8-i1aCanwwFzTjZ55odlVA"
        ]
    )
}
