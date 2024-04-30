//
//  HomeView.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-03-28.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var spotifyManager : SpotifyManager
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack{
            if let at = spotifyManager.accessToken {
                Text(at)
            }
            VStack{
                TopKeyboard()
                Spacer()
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(SpotifyManager.shared)
}
