//
//  MovieModel.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 18.10.2022.
//

import Foundation

struct Movie: Codable {
    let title, year, imdbID: String?
    let type: ContentType?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum ContentType: String, Codable {
    case movie
    case series
}
