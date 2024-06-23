//
//  Playlist.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import Foundation

// MARK: - Playlists
struct Playlists: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [PlaylistItem]
}

// MARK: - Item
struct PlaylistItem: Codable {
    let collaborative: Bool
    let description: String
    let externalUrls: ExternalUrls
    let href, id: String
    let images: [APIImage]
    let name: String
    let owner: Owner
    let itemPublic: Bool
    let snapshotID: String
    let tracks: Tracks
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - Owner
struct Owner: Codable {
    let externalUrls: ExternalUrls
    let followers: Tracks?
    let href, id, type, uri: String
    let displayName: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, href, id, type, uri
        case displayName = "display_name"
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String?
    let total: Int
}
