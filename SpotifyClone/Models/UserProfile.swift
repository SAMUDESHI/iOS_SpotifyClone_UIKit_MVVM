//
//  UserProfile.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import Foundation

struct UserProfile: Codable {
    let country, displayName, email: String
    let explicitContent: ExplicitContent
    let externalUrls: ExternalUrls
    let followers: Followers
    let href: String
    let id: String
    let images: [UserImage]
    let product, type, uri: String

    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case followers, href, id, images, product, type, uri
    }
}

// MARK: - ExplicitContent
struct ExplicitContent: Codable {
    let filterEnabled, filterLocked: Bool

    enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

struct UserImage: Codable{
    let image : String
    let width : Int?
    let height : Int?
    
}

// MARK: - Followers
struct Followers: Codable {
    let href: String?
    let total: Int
}
