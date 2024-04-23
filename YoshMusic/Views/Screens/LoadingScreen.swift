//
//  LoginScreen.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-03-28.
//

import SwiftUI

struct LoadingScreen: View {
    @EnvironmentObject var spotifyManager: SpotifyManager
    var body: some View {
        Button(action: {spotifyManager.connect()}){
            
            Text("Loading")
        }
    }
}

#Preview {
    LoadingScreen()
}
