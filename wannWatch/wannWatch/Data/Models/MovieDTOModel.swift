//
//  UserDTOModel.swift
//  wannWatch
//
//  Created by Student on 04.05.21.
//

import Foundation
import SwiftUI
import Combine

struct Initial: Codable {
    let results: [MovieDTO]
}


struct MovieDTO : Codable {
    let id: Int
    let title: String
    let originalLanguage: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let posterPath: String?
    
    
    func mapToMovie() -> Movie {
        // posterPath ?? ""
        return Movie(id: self.id, title: self.title, originalLanguage: self.originalLanguage, overview: self.overview,voteAverage: self.voteAverage, releaseDate: self.releaseDate ,posterPath: self.posterPath)
    }
    
//    enum CodingKeys: String, CodingKey {
//        case id, title
//        case originalLanguage = "original_language"
//    }
}
