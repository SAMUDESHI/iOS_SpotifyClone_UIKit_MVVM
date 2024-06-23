//
//  Artist.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import Foundation

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id, name: String
    let type: ArtistType
    let uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

enum ArtistType: String, Codable {
    case artist = "artist"
}
