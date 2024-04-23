//
//  ContentView.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-03-28.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var spotifyManager : SpotifyManager
    var body: some View {
        VStack {
            Button(action:{
                    Task{
                        try await SpotifyManager.shared.search()
                    }
            }){
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            
            if let at = spotifyManager.accessToken {
                Text(at)
            }
            
        }
        .padding()
    }
}

#Preview {
    MainScreen()
}
