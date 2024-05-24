//
//  YoshMusicApp.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-03-28.
//

import SwiftUI

@main
struct YoshMusicApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(SpotifyManager.shared)
                .environmentObject(SearchManager.shared)
                .environmentObject(NavigationManager.shared)
                .environmentObject(DatabaseManager.shared)
        }
    }
}
