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
import Router

@main
struct MoviesAppApp: App {
    
    private let networkService: Networkable
    @StateObject var router = Router()
    
    init() {
        networkService = NetworkService()
    }
   
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                MoviesCoordinator(dependencies: .init(network: networkService))
            }
            .tint(.white)
            .environmentObject(router)
        }
    }
}
