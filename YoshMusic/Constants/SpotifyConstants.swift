//
//  SpotifyConstants.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-02.
//

import Foundation

let SpotifyAccessTokenKey = "access-token-key"
let SpotifyRedirectURI = URL(string:"YoshMusic://")!
let SpotifyClientId = "a6750123c911486a823017f47402e1ad"
let SpotifyClientSecretKey = "12b3ba5c9fe94c1ab2abbad676782d5b"

let SpotifyApiHost = "api.spotify.com"
/*
Scopes let you specify exactly what types of data your application wants to
access, and the set of scopes you pass in your call determines what access
permissions the user is asked to grant.
For more information, see https://developer.spotify.com/web-api/using-scopes/.
*/

// Dash board at https://developer.spotify.com/dashboard

let SpotifyScopes: SPTScope = [
                            .userReadEmail, .userReadPrivate,
                            .userReadPlaybackState, .userModifyPlaybackState, .userReadCurrentlyPlaying,
                            .streaming, .appRemoteControl,
                            .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
                            .userLibraryModify, .userLibraryRead,
                            .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
                            .userFollowRead, .userFollowModify,
                        ]
let SpotifyStringScopes = [
                        "user-read-email", "user-read-private",
                        "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
                        "streaming", "app-remote-control",
                        "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
                        "user-library-modify", "user-library-read",
                        "user-top-read", "user-read-playback-position", "user-read-recently-played",
                        "user-follow-read", "user-follow-modify",
                    ]
