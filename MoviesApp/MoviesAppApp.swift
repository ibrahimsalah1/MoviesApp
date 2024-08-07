//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Ibrahim Salah on 05/08/2024.
//

import SwiftUI
import NetworkLayer
import Movies
import Router

@main
struct MoviesAppApp: App {
    
    //MARK: - Properties
    
    private let networkService: Networkable
    @StateObject private var router = Router()
    
    //MARK: - init
    
    init() {
        networkService = NetworkService()
    }
   
    //MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                MoviesCoordinator(
                    dependencies: .init(
                        network: networkService
                    )
                )
            }
            .tint(.white)
            .environmentObject(router)
        }
    }
}
