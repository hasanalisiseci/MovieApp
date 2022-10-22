//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 18.10.2022.
//

import Foundation

struct MovieDetail: Codable {
    let title, year, rated, released: String?
    let runtime, genre, director, writer: String?
    let actors, plot, language, country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let metascore, imdbRating, imdbVotes, imdbID: String?
    let type, dvd, boxOffice, production: String?
    let website, response: String?

    init(title: String? = nil, year: String? = nil, rated: String? = nil, released: String? = nil, runtime: String? = nil, genre: String? = nil, director: String? = nil, writer: String? = nil, actors: String? = nil, plot: String? = nil, language: String? = nil, country: String? = nil, awards: String? = nil, poster: String? = nil, ratings: [Rating]? = nil, metascore: String? = nil, imdbRating: String? = nil, imdbVotes: String? = nil, imdbID: String? = nil, type: String? = nil, dvd: String? = nil, boxOffice: String? = nil, production: String? = nil, website: String? = nil, response: String? = nil) {
        self.title = title
        self.year = year
        self.rated = rated
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.awards = awards
        self.poster = poster
        self.ratings = ratings
        self.metascore = metascore
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.imdbID = imdbID
        self.type = type
        self.dvd = dvd
        self.boxOffice = boxOffice
        self.production = production
        self.website = website
        self.response = response
    }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

struct Rating: Codable {
    let source, value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
