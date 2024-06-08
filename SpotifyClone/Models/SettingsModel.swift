//
//  SettingsModel.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 08/06/24.
//

import Foundation

struct Section{
    let title : String
    let option: [Option]
}

struct Option{
    let title : String
    let handler: () -> Void
}
