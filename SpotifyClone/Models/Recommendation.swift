//
//  Recommendation.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 18/06/24.
//

import Foundation

struct Recommendation: Codable {
    let seeds: [Seed]
    let tracks: [Track]
}

// MARK: - Seed
struct Seed: Codable {
    let afterFilteringSize, afterRelinkingSize: Int
    let href : String?
    let id: String
    let initialPoolSize: Int
    let type: String
}
