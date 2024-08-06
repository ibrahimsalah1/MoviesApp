//
//  MovieEndPointRequest.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import NetworkLayer

enum MovieEndPointRequest: EndPointRequest {
    
    case loadGenres
    case loadMovies(_ page: Int)
    
    var path: String {
        
        switch self {
        case .loadGenres:
            return MovieEndPoint.genres
            
        case .loadMovies:
            return MovieEndPoint.popularMovies
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var queryParameters: [String : String]? {
        
        switch self {
            
        case .loadMovies(let page):
            return [
                "include_adult": "false",
                "sort_by": "popularity.desc",
                "page": "\(page)"
            ]
       
        default: return nil
            
        }
    }
}
