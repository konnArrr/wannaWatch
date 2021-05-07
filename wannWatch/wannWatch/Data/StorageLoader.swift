//
//  StorageLoader.swift
//  wannWatch
//
//  Created by Student on 06.05.21.
//

import Foundation
import SwiftUI

class StorageLoader {
    static let shared = StorageLoader()
    @Published var favouriteMovieList = [Watchable]()
    @AppStorage("favouriteMovieList") private var dataForAppStorage: Data = Data()
    
    private init() {
        loadFavouriteMovieList()
    }
    
    public func moveFavouriteMovieListBy(from source: IndexSet, to destination: Int) {
        favouriteMovieList.move(fromOffsets: source, toOffset: destination)
        saveFavouriteMovieList()
    }
    
    public func deleteFromFavouriteMovieListBy(at offsets: IndexSet) {
        favouriteMovieList.remove(atOffsets: offsets)
        saveFavouriteMovieList()
    }
    
    public func saveToFavouriteMovieList(movie: Watchable) {
        favouriteMovieList.append(movie)
        saveFavouriteMovieList()
    }
    
    private func saveFavouriteMovieList() {
        guard let dataToSaveData: Data = try? JSONEncoder().encode(favouriteMovieList) else { return }
        self.dataForAppStorage = dataToSaveData
    }
    
    public func loadFavouriteMovieList() {
        guard let loadedDataObject = try? JSONDecoder().decode([Watchable].self, from: dataForAppStorage) else { return }
        favouriteMovieList = loadedDataObject
    }
     
    
}
