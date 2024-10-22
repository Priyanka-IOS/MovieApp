//
//  MoviesModelData.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import Foundation
// MARK: - MoviesModelData
struct MoviesModelData: Codable {
    let title, year, rated, released: String
    let runtime, genre, director, writer: String
    let actors, plot, language, country: String
    let awards: String
    let poster: String
    let ratings: [Rating]
    let metascore, imdbRating, imdbVotes, imdbID: String
    let type: String
    let boxOffice, production: String?
    let totalSeasons: String?

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
        case boxOffice = "BoxOffice"
        case production = "Production"
        case totalSeasons
    }
}

// MARK: - Rating
struct Rating: Codable {
    let source: Source
    let value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

enum Source: String, Codable {
    case internetMovieDatabase = "Internet Movie Database"
    case metacritic = "Metacritic"
    case rottenTomatoes = "Rotten Tomatoes"
}
struct Section {
    let title: SectionTitle
    var isExpanded: Bool
    let items: [String]
}

enum SectionTitle: String {
    case year = "Year"
    case genre = "Genre"
    case directors = "Directors"
    case actors = "Actors"
    case allMovies = "All Movies"
}
