//
//  ConnectButton.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-02.
//

import SwiftUI

struct ConnectButton: View {
    let screenWidth = UIScreen.main.bounds.size.width
    
    
    var body: some View {
        Button(action: {
            withAnimation {
                // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
                SpotifyManager.shared.sessionManager!.initiateSession(with: SpotifyScopes, options: .clientOnly)
                SpotifyManager.shared.isSignedIn = true
            }
        }) {
            VStack (spacing:0){
                Text("Album")
                    .font(.subheadline)
                    .bold()
                    .padding(.bottom,7.5)
            }
        }
    }
}


#Preview {
    ConnectButton()
}
