//
//  MovieGenresView.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import SwiftUI
import Domain

struct MovieGenresView: View {
    
    //MARK: - Properties
    
    let genres: [Genre]
    @Binding var selectedGenres: Int
    
    private let rows = [
        GridItem(.flexible())
    ]
    
    //MARK: - Body
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(genres, id: \.id) { genre in
                    MovieGenreItemView(
                        genre: genre,
                        selectedGenre: $selectedGenres
                    )
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .scrollIndicators(.hidden)
        .frame(height: 30)
        .padding(.bottom, 10)
    }
    
}
