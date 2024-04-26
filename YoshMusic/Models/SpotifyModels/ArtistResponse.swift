//
//  ArtistResponse.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-25.
//

import Foundation

struct ArtistResponse: Codable {
    let artists: ArtistList
}

struct ArtistList: Codable{
    let items: [ArtistItem]
}

struct ArtistItem: Codable {
    let name: String
    let followers: ArtistFollowers
    let images: [ArtistImages]
}

struct ArtistFollowers: Codable {
    let total: Int
}

struct ArtistImages: Codable {
    let height: Int
    let url: String
    let width: Int
}
