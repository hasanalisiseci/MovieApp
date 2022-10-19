//
//  MovieModel.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 18.10.2022.
//

import Foundation

struct Movie: Codable, Hashable {
    let title, year, imdbID, poster: String?
    let type: ContentType?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
        case type = "Type"
    }
}

enum ContentType: String, Codable {
    case movie
    case series
}
