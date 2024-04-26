//
//  APIErrors.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-25.
//

import Foundation

struct ErrorResponse: Codable {
    let error: APIMessage
}

struct APIMessage: Codable {
    let status: Int
    let message: String
}
