//
//  NewReleases.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 11/06/24.
//

import Foundation
// MARK: - NewReleases
struct NewReleases: Codable {
    let albums: Albums
}

// MARK: - Albums
struct Albums: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let albumType: AlbumTypeEnum
    let totalTracks: Int
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [APIImage]
    let name, releaseDate: String
    let releaseDatePrecision: ReleaseDatePrecision
    let type: AlbumTypeEnum
    let uri: String
    let artists: [Artist]

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case type, uri, artists
    }
}

enum AlbumTypeEnum: String, Codable {
    case album = "album"
    case ep = "ep"
    case single = "single"
}




enum ReleaseDatePrecision: String, Codable {
    case day = "day"
}
