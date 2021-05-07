//
//  MovieModel.swift
//  wannWatch
//
//  Created by Student on 04.05.21.
//

import Foundation


struct Movie: Identifiable, Codable {
    
    
    
    
    
    let id: Int
    let title: String
    let originalLanguage: String
    let overview: String
    let posterPath: String?
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    internal init(id: Int, title: String, originalLanguage: String, overview: String, posterPath: String?) {
        self.id = id
        self.title = title
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.posterPath = posterPath
    }
    
}
