//
//  DetailViewModel.swift
//  wannWatch
//
//  Created by Student on 06.05.21.
//

import Foundation

class DetailViewModel {

    public func saveMovieToFavourites(movie: Movie) {
        StorageLoader.shared.saveToFavouriteMovieList(movie: movie)
    }
    
    public func favouritesListContains( _ movie: Movie) -> Bool {
        return StorageLoader.shared.favouriteMovieList.contains { $0 == movie }
    }
    
    
    
}
