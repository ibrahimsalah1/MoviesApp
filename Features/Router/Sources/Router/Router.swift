//
//  Router.swift
//  
//
//  Created by Ibrahim Salah on 06/08/2024.
//

import Foundation
import SwiftUI

public class AnyIdentifiable: Identifiable {
    public let destination: any Identifiable

    public init(destination: any Identifiable) {
        self.destination = destination
    }
}

public final class Router: ObservableObject {
    @Published public var navPath = NavigationPath()

    public init() {}

    public func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    public func navigateBack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
