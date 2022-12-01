//
//  MovieModel.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable, Hashable{
    let movieList: [MovieList]
}

// MARK: - MovieList
struct MovieList: Codable, Hashable{
    let id: Int
    let title, description: String
    let rating: Double
    let duration, genre, releasedDate: String
    let trailerLink: String
}
