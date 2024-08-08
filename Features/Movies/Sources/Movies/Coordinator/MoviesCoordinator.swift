//
//  MoviesCoordinator.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import SwiftUI
import DataLayer
import Router
import DomainData
import NetworkLayer

enum Destination: Hashable {
    case movieDetail(movieId: Int)
}

public struct MoviesCoordinator: View {
    
    //MARK: - Properties
    
    private let dependencies: Dependencies
    
    //MARK: - init
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - Body
    
    public var body: some View {
        
        MoviesListView.init(
            repository: MoviesRepository(
                networkService: dependencies.network
            )
        )
        .navigationDestination(for: Destination.self) { destination in
            switch destination {
                
            case .movieDetail(let movieId):
                
                MovieDetailsView.init(
                    dependencies: .init(
                        
                        movieId: movieId,
                        movieDetailRepository: MovieDetailsRepository(
                            networkService: dependencies.network
                        )
                    )
                )
            }
        }
    }
}
