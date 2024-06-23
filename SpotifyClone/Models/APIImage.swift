//
//  APIImage.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 11/06/24.
//

import Foundation

// MARK: - APIImage
struct APIImage: Codable {
    let url: String
    let height, width: Int?
}
