//
//  Album.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 18/06/24.
//

import Foundation

// MARK: - Album
struct Album: Codable {
    let albumType: String
    let totalTracks: Int
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href, id: String
    let images: [APIImage]
    let name, releaseDate, releaseDatePrecision: String
    let restrictions: Restrictions
    let type, uri: String
    let artists: [Artist]

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case restrictions, type, uri, artists
    }
}
