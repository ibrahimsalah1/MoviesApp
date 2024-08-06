//
//  MoviesCoordinatorExtension.swift
//
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import NetworkLayer

 public extension MoviesCoordinator {
    
    struct Dependencies {
        let network: Networkable
        public init(network: Networkable) {
            self.network = network
        }
    }
}
