//
//  LandingView.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-03.
//

import SwiftUI

struct LandingView: View {
    @StateObject var spotifyManager: SpotifyManager = SpotifyManager.shared
    
    var body: some View {
        if spotifyManager.isSignedIn {
            MainScreen()
        }else{
            LoginScreen()
        }
    }
}

#Preview {
    LandingView()
}
