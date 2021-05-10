//
//  TvShowDTO.swift
//  wannWatch
//
//  Created by Student on 07.05.21.
//

import Foundation

import SwiftUI
import Combine

struct InitialTvShowDTO: Codable {
    let results: [TvShowDTO]
}


struct TvShowDTO : Codable {
    let id: Int
    let name: String
    let originalLanguage: String
    let overview: String
    let voteAverage: Double
    let firstAirDate: String
    let posterPath: String?
    
    
    func mapToWatchable() -> Watchable {
        return Watchable(id: self.id, title: self.name, originalLanguage: self.originalLanguage, overview: self.overview,voteAverage: self.voteAverage, releaseDate: self.firstAirDate ,posterPath: self.posterPath)
    }
    
}
