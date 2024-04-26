//
//  Constants.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-02.
//

import Foundation

struct Constants{
    
    enum APIError: Error {
        case timeOut
        case invalidURL
        case accessTokenExpired
        case unknown
    }
    
    enum SearchQueryType: String{
        case album = "album"
        case artist = "artist"
        case playlist = "playlist"
        case track = "track"
        case show = "show"
        case episode = "episode"
        case audiobook = "audiobook"
    }
    
    struct Spotify {
        static let SpotifyAccessTokenKey = "access-token-key"
        static let SpotifyRedirectURI = URL(string:"YoshMusic://")!
        static let SpotifyClientId = "a6750123c911486a823017f47402e1ad"
        static let SpotifyClientSecretKey = "12b3ba5c9fe94c1ab2abbad676782d5b"
        
        static let spotifyAccessTokenKeyExpireTimeInSeconds = 3600

        static let SpotifyApiHost = "api.spotify.com"

        static let SpotifyScopes: SPTScope = [
                                    .userReadEmail, .userReadPrivate,
                                    .userReadPlaybackState, .userModifyPlaybackState, .userReadCurrentlyPlaying,
                                    .streaming, .appRemoteControl,
                                    .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
                                    .userLibraryModify, .userLibraryRead,
                                    .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
                                    .userFollowRead, .userFollowModify,
                                ]
        static let SpotifyStringScopes = [
                                "user-read-email", "user-read-private",
                                "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
                                "streaming", "app-remote-control",
                                "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
                                "user-library-modify", "user-library-read",
                                "user-top-read", "user-read-playback-position", "user-read-recently-played",
                                "user-follow-read", "user-follow-modify",
                            ]
    }
}
