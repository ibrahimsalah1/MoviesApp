//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Ibrahim Salah on 05/08/2024.
//

import SwiftUI
import NetworkLayer
import Movies
import Domain
import DomainData

@main
struct MoviesAppApp: App {
    
    let network: Networkable
    
    init() {
        network = NetworkService()
    }
    
    var body: some Scene {
        
        WindowGroup {
            NavigationStack {
                MoviesListView(
                    repository: MoviesRepository(
                        networkService: network
                    )
                )
            }
        }
    }
}
