//
//  UserResponse.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-30.
//

import Foundation

class UserResponse: Response, Codable {
    let display_name: String
    let id: String
    let images: [UserImage]
}

struct UserImage: Codable {
    let url: String
}
