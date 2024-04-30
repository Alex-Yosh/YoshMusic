//
//  TopKeyboard.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-25.
//

import SwiftUI

struct TopKeyboard: View {
    @EnvironmentObject var spotifyManager: SpotifyManager
    @EnvironmentObject var searchManager: SearchManager
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0){
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Constants.Colours.Crystal, Constants.Colours.Nyanza]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                HStack{
                    TextField("Search Artist", text: $searchManager.searchInputHome)
                        .focused($isFocused)
                        .onChange(of: searchManager.searchInputHome){
                            Task {
                                searchManager.artistList = await spotifyManager.searchArtist(searchQuery: searchManager.searchInputHome)
                            }
                        }
                        .foregroundColor(.white)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 14).foregroundColor(.white.opacity(0.4)))
                    
                    Button(action: {
                        if searchManager.searchInputHome.isEmpty{
                            //focus on searchbar
                            isFocused = true
                        }else{
                            //clear text, unfocus searchbar
                            searchManager.searchInputHome = ""
                            isFocused = false
                        }
                    }){
                        ZStack{
                            Circle()
                                .foregroundColor(!searchManager.searchInputHome.isEmpty ? .red : Constants.Colours.Soap)
                            
                            Image(systemName: !searchManager.searchInputHome.isEmpty ? "x.circle" : "magnifyingglass")
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                }
                .padding(.leading)
            }.frame(height: 80)
            
            ScrollView(){
                VStack(spacing: 0){
                    ForEach(Array(searchManager.filteredArtistItems().enumerated()), id: \.offset){ index, artist in
                        ArtistsCard(artist: artist)
                        if index != searchManager.filteredArtistItems().count-1 || index == 0{
                            Divider()
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    TopKeyboard()
        .environmentObject(SpotifyManager.shared)
        .environmentObject(SearchManager.shared)
}
