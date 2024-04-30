//
//  SearchManager.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-29.
//

import Foundation

final class SearchManager: ObservableObject{
    static let shared = SearchManager() //singlton
    
    @Published var artistList: ArtistList?
    @Published var selectedArtist: ArtistItem?
    
    @Published var searchInputHome: String = ""
    
    func filteredArtistItems() -> [ArtistItem]{
        var artistlist: [ArtistItem] = []
        
        if let artistList = artistList{
            artistlist = artistList.items.filter {$0.name.lowercased().contains(searchInputHome.lowercased())}
        }
        
        return artistlist
    }
    
}
