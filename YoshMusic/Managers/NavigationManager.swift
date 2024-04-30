//
//  NavigationManager.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-29.
//

import Foundation
import SwiftUI

final class NavigationManager: ObservableObject {
    static let shared = NavigationManager()
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Constants.Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
