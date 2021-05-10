//
//  DetailViewModel.swift
//  wannWatch
//
//  Created by Student on 06.05.21.
//

import Foundation

class DetailViewModel {
    
    public func saveMovieToFavourites(movie: Watchable) {
        StorageLoader.shared.saveToFavouriteMovieList(movie: movie)
    }
    
    public func favouritesListContains( _ movie: Watchable) -> Bool {
        return StorageLoader.shared.favouriteMovieList.contains { $0 == movie }
    }
    
    
    
}
