//
//  AudioTrack.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import Foundation

// MARK: - Track
struct Track: Codable {
    let album: Album
    let artists: [TrackArtist]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let href, id: String
    let isPlayable: Bool
    let linkedFrom: LinkedFrom
    let restrictions: Restrictions
    let name: String
    let popularity: Int
    let previewURL: String
    let trackNumber: Int
    let type, uri: String
    let isLocal: Bool

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isPlayable = "is_playable"
        case linkedFrom = "linked_from"
        case restrictions, name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
        case isLocal = "is_local"
    }
}
