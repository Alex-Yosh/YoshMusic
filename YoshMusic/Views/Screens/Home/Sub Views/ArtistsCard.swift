//
//  ArtistsCard.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-29.
//

import SwiftUI

struct ArtistsCard: View {
    @EnvironmentObject var searchManager: SearchManager
    @EnvironmentObject var navManager: NavigationManager
    @EnvironmentObject var dbManager: DatabaseManager
    
    var artist: ArtistItem
    
    var body: some View {
        ZStack{
            Constants.Colours.VeryLightGreen
            Button(action:{
                navigateToArtistScreen()
            }){
                    HStack{
                        if !artist.images.isEmpty{
                            AsyncImage(url: URL(string: artist.images[0].url)){ image in
                                image
                                    .artistImageModifier()
                            } placeholder: {
                                ProgressView()
                            }
                        }else{
                            Image(systemName: "person.circle")
                                .artistImageModifier()
                        }
                        
                        Spacer()
                        Text(artist.name)
                            .modifier(ArtistCardNameText())
                    }.padding(.horizontal)
                
            }
        }
        .frame(height: 80)
    }
    
    //MARK: Helpers
    func navigateToArtistScreen(){
        searchManager.selectedArtist = artist
        navManager.navigate(to: .artist)
    }
}

#Preview {
    ArtistsCard(artist: ArtistItem(name: "Post Malone", followers: ArtistFollowers(total: 10), images: [ArtistImages(height: 64, url: "https://i.scdn.co/image/ab6761610000e5eb6be070445b03e0b63147c2c1", width: 64)]))
}
