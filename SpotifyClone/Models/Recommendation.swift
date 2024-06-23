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
    let href, id: String
    let initialPoolSize: Int
    let type: String
}









// MARK: - Restrictions
struct Restrictions: Codable {
    let reason: String
}

// MARK: - TrackArtist
struct TrackArtist: Codable {
    let externalUrls: ExternalUrls
    let followers: Followers
    let genres: [String]
    let href, id: String
    let images: [APIImage]
    let name: String
    let popularity: Int
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}



// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc, ean, upc: String
}

// MARK: - LinkedFrom
struct LinkedFrom: Codable {
}
