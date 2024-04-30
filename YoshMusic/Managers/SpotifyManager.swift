//
//  SpotifyManager.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-02.
//

import Foundation
import SwiftUI
import Combine

final class SpotifyManager: NSObject, ObservableObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate{
    static let shared = SpotifyManager() //singleton
    
    
    var currImage: UIImage?
    var currTrack: String?
    var currIsPaused: Bool?
    
    @Published var isSignedIn: Bool
    var playURI = ""
    
    @AppStorage(Constants.Spotify.SpotifyAccessTokenKey) var accessToken: String? {
        didSet{
            isSignedIn = accessToken != nil
            UserDefaults.standard.set(accessToken, forKey: Constants.Spotify.SpotifyAccessTokenKey)
        }
    }
    private var timer: Timer?
    
    
    private var connectCancellable: AnyCancellable?
    
    private var disconnectCancellable: AnyCancellable?
    
    
    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: Constants.Spotify.SpotifyClientId, redirectURL: Constants.Spotify.SpotifyRedirectURI)
        // Set the playURI to a non-nil value so that Spotify plays music after authenticating and App Remote can connect
        // otherwise another app switch will be required
        configuration.playURI = ""
        
        // Set these url's to your backend which contains the secret to exchange for an access token
        // You can use the provided ruby script spotify_token_swap.rb for testing purposes
        configuration.tokenSwapURL = URL(string: "http://localhost:1234/swap")
        configuration.tokenRefreshURL = URL(string: "http://localhost:1234/refresh")
        return configuration
    }()
    
    
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    private var lastPlayerState: SPTAppRemotePlayerState?
    
    override init() {
        //for testing
        //        UserDefaults.standard.removeObject(forKey: Constants.Spotify.SpotifyAccessTokenKey)
        
        let accessToken = UserDefaults.standard.string(forKey: Constants.Spotify.SpotifyAccessTokenKey)
        _isSignedIn = Published(initialValue: accessToken != nil)
        super.init()
    }
    
    func connect() {
        guard let _ = self.appRemote.connectionParameters.accessToken else {
            self.appRemote.authorizeAndPlayURI("")
            
            connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    self.connect()
                }
            
            disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    self.disconnect()
                }
            return
        }
        
        appRemote.connect()
    }
    
    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }else{
            connectCancellable = nil
            disconnectCancellable = nil
        }
    }
    
    func fetchPlayerState() {
        appRemote.playerAPI?.getPlayerState({ [weak self] (playerState, error) in
            if let error = error {
                print("Error getting player state:" + error.localizedDescription)
            } else if let playerState = playerState as? SPTAppRemotePlayerState {
                self?.update(playerState: playerState)
            }
        })
    }
    
    func fetchArtwork(for track:SPTAppRemoteTrack) {
        appRemote.imageAPI?.fetchImage(forItem: track, with: CGSize.zero, callback: { [weak self] (image, error) in
            if let error = error {
                print("Error fetching track image: " + error.localizedDescription)
            } else if let image = image as? UIImage {
                self?.currImage = image
            }
        })
    }
    
    
    func update(playerState: SPTAppRemotePlayerState) {
        if lastPlayerState?.track.uri != playerState.track.uri {
            fetchArtwork(for: playerState.track)
        }
        lastPlayerState = playerState
        currTrack = playerState.track.name
        currIsPaused = playerState.isPaused
    }
    
    
    func storeAccessToken(from url: URL){
        let parameters = appRemote.authorizationParameters(from: url)
        
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(errorDescription)
        }
    }
    
    func resetAccessToken(){
        UserDefaults.standard.removeObject(forKey: Constants.Spotify.SpotifyAccessTokenKey)
        accessToken = nil
        appRemote.connectionParameters.accessToken = nil
        disconnect()
    }
    
    // MARK: - SPTAppRemoteDelegate
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.appRemote = appRemote
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        lastPlayerState = nil
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        lastPlayerState = nil
    }
    
    // MARK: - SPTAppRemotePlayerAPIDelegate
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        update(playerState: playerState)
    }
    
    // MARK: WEB API
    
    //Public Functions
    
    func SpotifyAPICall(calltype: Constants.APICallType, queryType: Constants.QueryType? = nil, searchQuery: String? = nil) async -> Response?{
        do{
            switch(calltype){
            case .search:
                if let qt = queryType, let sq = searchQuery{
                    return try await search(queryType: qt, searchQuery: sq)
                }else{
                    print("need querytype and searchquery if you want to perform a search")
                    return nil
                }
                
            case .user:
                return try await userDetails()
                
            default:
                return nil
            }
        } catch Constants.APIError.accessTokenExpired{
            resetAccessToken()
            return nil
        } catch Constants.APIError.invalidURL{
            //            print("invalid url")
            return nil
        } catch Constants.APIError.unknown{
            //            print("unknown")
            return nil
        } catch{
            return nil
        }
    }
    
    //private helper functions
    
    private func search(queryType: Constants.QueryType, searchQuery: String) async throws -> Response{
        
        guard let urlRequest = createURLRequest(callType: .search, queryType: queryType, searchQuery: searchQuery) else {throw Constants.APIError.invalidURL}
        
        return try await decodeAs(urlRequest: urlRequest, apiType: .search, searchQueryType: queryType)
    }
    
    private func userDetails() async throws -> Response{
        
        guard let urlRequest = createURLRequest(callType: .user) else {throw Constants.APIError.invalidURL}
        
        return try await decodeAs(urlRequest: urlRequest, apiType: .user)
    }
    
    private func createURLRequest(callType: Constants.APICallType, queryType: Constants.QueryType? = nil, searchQuery: String? = nil) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.Spotify.SpotifyApiHost
        
        //path based on calltype
        components.path = callType.rawValue
        
        //add params
        switch(callType){
        case .search:
            components.queryItems = [
                URLQueryItem(name: "type", value: queryType!.rawValue),
                URLQueryItem(name: "q", value: searchQuery)
            ]
            
        default:
            break
            
        }
        
        guard let url = components.url else {return nil}
        
        var urlRequest = URLRequest(url: url)
        
        guard let at = accessToken else {return nil}
        
        //add headers
        urlRequest.addValue("Bearer " + at, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
    
    private func decodeAs(urlRequest: URLRequest, apiType: Constants.APICallType, searchQueryType: Constants.QueryType? = nil) async throws -> Response{
        let decoder = JSONDecoder()
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        do {
            switch(apiType){
            case .user:
                return try decoder.decode(UserResponse.self, from: data)
            case .search:
                if let qt = searchQueryType{
                    switch(qt){
                    case .artist:
                        return try decoder.decode(ArtistResponse.self, from: data)
                        
                    default:
                        throw Constants.APIError.unknown
                    }
                }
                else{
                    throw Constants.APIError.unknown
                }
                
            }
            
        } catch {
            let results = try decoder.decode(ErrorResponse.self, from: data)
            switch results.error.message{
            case "The access token expired":
                print(results.error.message)
                throw Constants.APIError.accessTokenExpired
                
            default:
                throw Constants.APIError.unknown
                
            }
        }
    }
}



