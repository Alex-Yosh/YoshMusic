//
//  ArtistScreen.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-29.
//

import SwiftUI

struct ArtistScreen: View {
    @EnvironmentObject var searchManager: SearchManager
    
    var body: some View {
        if let artist = searchManager.selectedArtist{
            Text(artist.name)
        }else{
            Text("unknown artist")
        }
    }
}

#Preview {
    ArtistScreen()
}
