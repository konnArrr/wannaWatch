//
//  MovieModel.swift
//  wannWatch
//
//  Created by Student on 04.05.21.
//

import Foundation


struct Watchable: Identifiable, Codable, Equatable {
    
    
    let id: Int
    let title: String
    let originalLanguage: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let posterPath: String?
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    internal init(id: Int, title: String, originalLanguage: String, overview: String, voteAverage: Double, releaseDate: String, posterPath: String?) {
        self.id = id
        self.title = title
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.posterPath = posterPath
    }
    
    static func == (lhs: Watchable, rhs: Watchable) -> Bool {
        return lhs.id == rhs.id
    }
    
}
