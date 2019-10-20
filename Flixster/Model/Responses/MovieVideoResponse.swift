//
//  MovieVideoResponse.swift
//  Flixster
//
//  Created by Julio Cesar Whatley on 10/20/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

// MARK: - VideoResponse
struct VideoResponse: Codable {
    let id: Int
    let results: [VideoResult]
}

// MARK: - Result
struct VideoResult: Codable {
    let id, iso639_1, iso3166_1, key: String
    let name, site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
