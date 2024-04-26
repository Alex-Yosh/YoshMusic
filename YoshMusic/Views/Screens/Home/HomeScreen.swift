//
//  HomeView.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-03-28.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var spotifyManager : SpotifyManager
    var body: some View {
        VStack {
            TopKeyboard()
            Spacer()
            
            if let at = spotifyManager.accessToken {
                Text(at)
            }
            
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(SpotifyManager.shared)
}
