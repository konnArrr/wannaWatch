//
//  FavouritesViewModel.swift
//  wannWatch
//
//  Created by Student on 06.05.21.
//

import Foundation
import Combine

class FavouritesViewModel: ObservableObject {
    @Published private(set) var favouriteMoviesVm = [Watchable]()
    private var cancellbale: AnyCancellable?
    init() {
        cancellbale = StorageLoader.shared.$favouriteMovieList.sink(receiveValue: { [weak self] favouriteMovies in
            self?.favouriteMoviesVm = favouriteMovies
        })
    }
    
    func deleteFromFavouriteList(at offsets: IndexSet) {
        StorageLoader.shared.deleteFromFavouriteMovieListBy(at: offsets)
    }
    
    func moveFavouriteList(from source: IndexSet, to destination: Int) {
        StorageLoader.shared.moveFavouriteMovieListBy(from: source, to: destination)
    }
    
}
