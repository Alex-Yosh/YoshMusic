//
//  ContentView.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-03-28.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
        }
        .padding()
        .onAppear{
            Task{
                try await SpotifyManager.shared.search()
            }
        }
    }
}

#Preview {
    MainScreen()
}
