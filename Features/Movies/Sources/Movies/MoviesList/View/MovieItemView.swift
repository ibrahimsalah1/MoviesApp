//
//  MovieItemView.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import SwiftUI
import Domain
import SDWebImageSwiftUI

struct MovieItemView: View {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            WebImage(url: movie.posterPath) { image in
                image.resizable()
                    .frame(height: 280)
            } placeholder: {
                Image(systemName: "movieclapper")
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            
            
            Spacer()
            
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
                .foregroundColor(.white)
            
            Text(movie.releaseDate)
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
        }
        .frame(height: 400)
        .frame(maxWidth: .infinity)
        .background(Color.init(hex: "1A1A1A"))
    }
}
