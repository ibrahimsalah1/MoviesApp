//
//  MovieGenreItemView.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import SwiftUI
import Domain

struct MovieGenreItemView: View {
    
    //MARK: - Properties
    
    let genre: Genre
    @Binding var selectedGenre: Int
    
    //MARK: - Body
    
    var body: some View {
        Text(genre.name.rawValue)
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(selectedGenre == genre.id ? .black : .white)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .background(selectedGenre == genre.id ? Color.init(hex: "#CFA614") : .clear)
            .clipped()
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(
                        Color.init(hex: "#CFA614"),
                        lineWidth: 1
                    )
            }
            .onTapGesture {
                if selectedGenre == genre.id {
                    selectedGenre = -1
                } else {
                    selectedGenre = genre.id
                }
            }
    }
}
