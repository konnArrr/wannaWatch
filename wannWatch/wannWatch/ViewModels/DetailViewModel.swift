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
}
