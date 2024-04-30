//
//  LandingView.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-03.
//

import SwiftUI

struct LandingView: View {
    
    @EnvironmentObject var spotifyManager: SpotifyManager
    @EnvironmentObject var navManager: NavigationManager
    
    var body: some View {
        if spotifyManager.isSignedIn {
            NavigationStack(path: $navManager.navPath) {
                HomeScreen()
                .navigationDestination(for: Constants.Destination.self) { destination in
                    switch destination {
                    case .artist:
                        HomeScreen()
                    }
                }
            }
        }else{
            LoadingScreen()
                .onOpenURL { url in
                    spotifyManager.storeAccessToken(from: url)
                }
        }
    }
}

#Preview {
    LandingView()
}
