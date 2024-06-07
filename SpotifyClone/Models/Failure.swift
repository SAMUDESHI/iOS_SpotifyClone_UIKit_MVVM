//
//  Failure.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 07/06/24.
//

import Foundation

// MARK: - Failure
struct Failure: Codable {
    let error: ErrorSpotify
}

// MARK: - Error
struct ErrorSpotify: Codable {
    let status: Int
    let message: String
}
