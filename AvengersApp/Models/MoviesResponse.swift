//
//  MoviesResponse.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import Foundation

struct MovieSearchResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let overview: String?
    let posterPath: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
