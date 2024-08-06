//
//  MovieDetailsInfoItem.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import SwiftUI

struct MovieDetailsInfoItem: View {
    
    struct Info {
        let title: String
        let value: String
    }
    
    //MARK: - Properties
    
    private let info: Info
    
    //MARK: - init
    
    init(info: Info) {
        self.info = info
    }
    
    //MARK: - Body
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(info.title):")
                .font(.system(size: 16, weight: .bold))
            
            Text(info.value)
                .foregroundStyle(.white.opacity(0.9))
                .font(.system(size: 16, weight: .regular))
        }
    }
}
