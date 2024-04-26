//
//  TopKeyboard.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-25.
//

import SwiftUI

struct TopKeyboard: View {
    @EnvironmentObject var spotifyManager: SpotifyManager
    @State var inputText: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Constants.Colors.Crystal, Constants.Colors.Nyanza]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea()
            HStack{
                TextField("Search Artist", text: $inputText)
                    .padding(.leading)
                    .foregroundColor(.white)
                Button(action: {
                    
                    Task{
                        await SpotifyManager.shared.searchArtist(searchQuery: inputText)
                    }
                }){
                    ZStack{
                        Circle()
                            .foregroundColor(Constants.Colors.Soap)
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }.frame(height: 80)
    }
}

#Preview {
    TopKeyboard()
}
