//
//  Constants.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-02.
//

import Foundation

struct Constants{
    
    enum Destination: Codable, Hashable {
        case artist
    }
    
    enum APIError: Error {
        case timeOut
        case invalidURL
        case accessTokenExpired
        case unknown
    }
    
    
    enum APICallType: String{
        case search = "/v1/search"
        case user = "/v1/me"
    }
    
    enum QueryType: String{
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
        static let SpotifyClientId = Bundle.main.object(forInfoDictionaryKey: "Spotify Client ID") as! String
        static let SpotifyClientSecretKey = Bundle.main.object(forInfoDictionaryKey: "Spotify Client Secret Key") as! String
        
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
